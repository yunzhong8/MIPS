`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 18:53:12
// Design Name: 
// Module Name: Controller_Uint
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller_Uint(
input clk,
input rst_l,
input  [5:0]Op,
input [5:0]Func,

output Bne,
output Beq,
output MemRead,
output MemWrite,
output RegWrite,
output PcWrite,
output IrWrite,
output RegDst,
output MemToReg,
output[1:0] AluSrcB,
output AluSrcA,
output PCsrc,
output lorD,
output reg[3:0]ALU_OP,
output [3:0]mini_address



    );
    //本处错误点在于把as_in_instr写错为ad_in_instr导致输出错误 ，找了半天 
    //地址转移器也写错了：原因在于输入输出对应关系错了 
//*******************************************Define Inner Variable（定义内部变量）***********************************************//
    reg LW=1'b0,SW=1'b0,BEQ=1'b0,BNE=1'b0,ADDI=1'b0,R=1'b0;
    reg ADD=1'b0,SLT=1'b0,SysCall=1'b0;
    wire R_TYPE;
      
    //地址转移器
    wire [6:0]as_in_instr;//地址转移器的输入
    wire [3:0]as_out_address;//地址转移的输出
    
    //指令控制存储器
    reg [20:0]Addr_Mem[15:0];
    wire[3:0] next_addr;//指令的下址
    reg [3:0]ad_ra;//控制存储器的访问地址
    wire [20:0]Instruct;
    
    //地址控制信号 
    wire P;
    
    //ALU控制信号
    wire [1:0]ALU_Control;
    ////////////////////////////////////logic implementation
//    always@(*)
//        $monitor($time,,"控制器输入的：Op=%h,Func=%h",Op,Func);
//*******************************************loginc Implementation（程序逻辑实现）***********************************************//
  //识别L指令和其他指令指令类型
    always @(*)
    case(Op)
    6'h23:
        begin 
            LW<=1'b1;
             SW<=1'b0;BEQ<=1'b0;BNE<=1'b0;ADDI<=1'b0;R<=1'b0;
             ADD<=1'b0;SLT<=1'b0;SysCall<=1'b0;
        end
    6'h2b: 
             begin 
                    SW<=1'b1;
                    LW<=1'b0;BEQ<=1'b0;BNE<=1'b0;ADDI<=1'b0;R<=1'b0;
                    ADD<=1'b0;SLT<=1'b0;SysCall<=1'b0;
              end
    6'h04:
             begin 
                    BEQ<=1'b1;
                    SW<=1'b0;LW<=1'b0;BNE<=1'b0;ADDI<=1'b0;R<=1'b0;
                    ADD<=1'b0;SLT<=1'b0;SysCall<=1'b0;
              end
    6'h05: 
            begin 
                    BNE<=1'b1;
                    BEQ<=1'b0;SW<=1'b0;LW<=1'b0;ADDI<=1'b0;R<=1'b0;
                    ADD<=1'b0;SLT<=1'b0;SysCall<=1'b0;
              end
    6'h08: 
             begin 
                    ADDI<=1'b1;
                    BNE<=1'b0;BEQ<=1'b0;SW<=1'b0;LW<=1'b0;R<=1'b0;
                    ADD<=1'b0;SLT<=1'b0;SysCall<=1'b0;
              end
            
    6'h00:
             case(Func)//识别其他指令中：R型，J型，Syscall
                    6'h20:
                             begin 
                                    R<=1'b1; ADDI<=1'b0;BNE<=1'b0;BEQ<=1'b0;SW<=1'b0;LW<=1'b0;
                                    ADD<=1'b1;SLT<=1'b0;SysCall<=1'b0;
                              end
                    6'h2a:
                            begin 
                                    R<=1'b1; ADDI<=1'b0;BNE<=1'b0;BEQ<=1'b0;SW<=1'b0;LW<=1'b0;
                                    ADD<=1'b0;SLT<=1'b1;SysCall<=1'b0;
                              end
                    8'h0c:
                            begin 
                                    R<=1'b0; ADDI<=1'b0;BNE<=1'b0;BEQ<=1'b0;SW<=1'b0;LW<=1'b0;
                                    ADD<=1'b0;SLT<=1'b0;SysCall<=1'b1;
                              end
                    endcase
    
    endcase
    
    
    
    //ALU控制信号产生 
    always@(*)
        case(ALU_Control)
            2'b00:ALU_OP<=4'd5;
            2'b01:ALU_OP<=4'd6;
            2'b10:ALU_OP<=(Func==6'h2a)?4'hb:4'h5;
        endcase
   
    
    //地址转移器
     assign as_in_instr ={(ADD|SLT)&~SysCall,ADDI,LW,SW,BEQ,BNE,SysCall};
//    always @(ADD,SLT,SysCall,ADDI,LW,SW,BEQ,BNE,SysCall)
//    begin
//        $display($time,,"当前状态对应的指令；RType=%h,ADDI=%h,LW=%h,SW=%h,BEQ=%h,BNE=%h,SysCall=%h",(ADD|SLT)&~SysCall,ADDI,LW,SW,BEQ,BNE,SysCall);
//        $display($time,,"地址转移器的输入：ad_in_instr=%h",as_in_instr);
//    end
    Address_Shift AS(as_in_instr,as_out_address);
//    always@(*)
//         $display($time,,"地址转移器的输出：as_out_address=%h",as_out_address);
   
    //信号存储器
    reg [3:0]i=4'h0;
    always@(posedge clk,negedge rst_l)
        if(!rst_l)//初始化信号存储器地址为0
            begin
            $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Monocyclic_MIPS_CPU8_2/Mem_data/CU_Mem.txt",Addr_Mem);
            ad_ra<=4'h0;
            i<=4'h0;
//            $display("初始化微程序存储器内保存指令值");
//            repeat(16)
//                begin
//                    $display("Addr_Mem[%d]=%h",i,Addr_Mem[i]);
//                     i=i+4'h1;
//                end
            end
        else    if(P)//P为1,为译指：取出的指令对应的信号存储器地址
                 ad_ra<=as_out_address;
            else//P为0时候信号存储器地址为指令下址
                 ad_ra<=next_addr;
    assign Instruct=Addr_Mem[ad_ra];//读取指令 
//     always@(*)
//     begin
//          $monitor($time,,"微程序信号存储器本次访问地址：ad_ra=%h",ad_ra);
//        $monitor($time,,"取出的微程序信号指令：Instruct=%h",Instruct);
//     end
     
    //右指令产生控制信号
    assign next_addr=Instruct[3:0];//取出下址
    assign mini_address=next_addr;
//    always@(*)
//        $monitor($time,,"下地址：next_addr=%b",next_addr);
    assign P=Instruct[4];//取出地址控制信号 
//     always@(*)
//        $monitor($time,,"P=%b",P);
    assign ALU_Control=Instruct[6:5];//取出ALU运算控制信号 
//      always@(*)
//        $monitor($time,,"控制器内部：当前状态的运算器信号：ALU_Control=%b",ALU_Control);
    assign {lorD,PCsrc,AluSrcA,AluSrcB, MemToReg,RegDst,IrWrite,PcWrite,RegWrite,MemWrite,MemRead,Beq,Bne}=Instruct[20:7];//取出控制信号 
//     always@(*)
//     begin
//        $monitor($time,,"控制器内部：当前状态的信号：lorD=%b,PCsrc=%b,AluSrcA=%b,AluSrcB=%b, MemToReg=%b,RegDst=%b,IrWrite=%b,",Instruct[20],Instruct[19],Instruct[18],Instruct[17:16],Instruct[15],Instruct[14],Instruct[13]);
//        $monitor($time,," 控制器内部：PcWrite=%b,RegWrite=%b,MemWrite=%b,MemRead=%b,Beq=%b,Bne=%b",Instruct[12],Instruct[11],Instruct[10],Instruct[9],Instruct[8],Instruct[7]);
//        end













    
    
    
    
    
    
endmodule
