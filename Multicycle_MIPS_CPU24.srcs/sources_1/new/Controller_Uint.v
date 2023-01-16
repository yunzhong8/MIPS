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
output JMP,
output JR,
output JAL,
output Syscall,
output SignedExt,
output [3:0]mini_address



    );
    parameter MC_LEN=5'd31;
    //本处错误点在于把as_in_instr写错为ad_in_instr导致输出错误 ，找了半天 
    //地址转移器也写错了：原因在于输入输出对应关系错了 
//*******************************************Define Inner Variable（定义内部变量）***********************************************//
    //指令识别模块变量定义 
    reg [4:0]CU_address;//指令输入存储器的地址
    reg[11:0]CU_I_Mem[24:0] ;//存储每个指令对应的状态机中的地址
    reg[4:0]CU_Alu_Mem[24:0] ;//存储每个指令对应的运算器的运算控制值
      
    //地址转移器
    wire [6:0]as_in_instr;//地址转移器的输入
    wire [5:0]as_out_address;//地址转移的输出
    
    //指令控制存储器
    reg [26:0]Addr_Mem[26:0];
    wire[4:0] next_addr;//指令的下址
    reg [4:0]ad_ra;//控制存储器的访问地址
    wire [26:0]Instruct;
    
    //地址控制信号 
    wire P;
    
    //ALU控制信号
    wire [1:0]ALU_Control;
    ////////////////////////////////////logic implementation
//    always@(*)
//        $monitor($time,,"控制器输入的：Op=%h,Func=%h",Op,Func);
//*******************************************loginc Implementation（程序逻辑实现）***********************************************//

 //$$$$$$$$$$$$$$$（ 指令识别 模块）$$$$$$$$$$$$$$$$$$// 
  //识别L指令和其他指令指令类型
   always @(*)
    if(!rst_l)
        begin
            $readmemb("D:/Documents/Hardware_verlog/Source_Data/Multicycle_MIPS_CPU24/CU_Addr_Data.txt",CU_I_Mem,1);
            $readmemh("D:/Documents/Hardware_verlog/Source_Data/Multicycle_MIPS_CPU24/CU_ALU_Data.txt",CU_Alu_Mem,1);
//            repeat(24)
//                    begin
//                     $display($time,,"CU_I_Mem[%d]=%h,CU_Alu_Mem[%d]=%h",i,CU_I_Mem[i],i,CU_Alu_Mem[i]);
//                     i=i+5'h1;
//                     end 
      end
        
    else    if(Op==6'h0)
                    case(Func)
                        6'd0:CU_address<=5'd1;//SLL
                        6'd3:CU_address<=5'd2;//SRA
                        6'd2:CU_address<=5'd3;//SRL
                        6'd32:CU_address<=5'd4;//ADD
                        6'd33:CU_address<=5'd5;//ADDU
                        6'd34:CU_address<=5'd6;//SUB
                        6'd36:CU_address<=5'd7;//AND
                        6'd37:CU_address<=5'd8;//OR 
                        6'd39:CU_address<=5'd9;//NOR
                        6'd42:CU_address<=5'd10;//SLT
                        6'd43:CU_address<=5'd11;//SLTU
                        6'd8:CU_address<=5'd12;//JR
                        6'd12:CU_address<=5'd13;//SYSCALL
                      endcase
                else
                    case(Op)
                        6'd2:CU_address<=5'd14;//J
                        6'd3:CU_address<=5'd15;//JAL 
                        6'd4:CU_address<=5'd16;//BEQ 
                        6'd5:CU_address<=5'd17;//BNE 
                        6'd8:CU_address<=5'd18;//ADDI 
                        6'd12:CU_address<=5'd19;//ANDI
                        6'd9:CU_address<=5'd20;//ADDIU
                        6'd10:CU_address<=5'd21;//SLTI
                        6'd13:CU_address<=5'd22;//ORI
                        6'd35:CU_address<=5'd23;//LW
                        6'd43:CU_address<=5'd24;//SW
                    endcase
    //#################（ 模块结束）#################//  
  
    
  
    //$$$$$$$$$$$$$$$（ 地址转移器  模块）$$$$$$$$$$$$$$$$$$//
        //模块输入：
            assign as_in_instr =CU_I_Mem[CU_address];
        //模块调用：
            assign as_out_address=as_in_instr;
        //模块输入输出显示：     
//            always @(ADD,SLT,SysCall,ADDI,LW,SW,BEQ,BNE,SysCall)
//            begin
//                $display($time,,"当前状态对应的指令；RType=%h,ADDI=%h,LW=%h,SW=%h,BEQ=%h,BNE=%h,SysCall=%h",(ADD|SLT)&~SysCall,ADDI,LW,SW,BEQ,BNE,SysCall);
//                $display($time,,"地址转移器的输入：",as_in_instr);
//            end
         
//            always@(*)
//                 $display($time,,"输入指令标号译码出对应指令微地址：CU_address=%h,as_out_address=%h",CU_address,as_out_address); 
  
	//#################（ 模块结束）#################//  
    
    
    
    //$$$$$$$$$$$$$$$（ 信号存储器 模块）$$$$$$$$$$$$$$$$$$// 
        reg [3:0]i=4'h0;
        always@(posedge clk,negedge rst_l)
            if(!rst_l)//初始化信号存储器地址为0
                begin
                $readmemh("D:/Documents/Hardware_verlog/Source_Data/Multicycle_MIPS_CPU24/CU_Sign_Data.txt",Addr_Mem);
                ad_ra<=4'h0;
                i<=4'h0;
//                $display("初始化微程序存储器内保存指令值");
//                repeat(16)
//                    begin
//                        $display("Addr_Mem[%d]=%h",i,Addr_Mem[i]);
//                         i=i+4'h1;
//                    end
                end
            else    if(P)//P为1,为译指：取出的指令对应的信号存储器地址
                     ad_ra<=as_out_address;
                else//P为0时候信号存储器地址为指令下址
                     ad_ra<=next_addr;
	//#################（ 模块结束）#################//  
   
   
    //$$$$$$$$$$$$$$$（ CU控制信号产生 模块）$$$$$$$$$$$$$$$$$$// 
    
         assign Instruct=Addr_Mem[ad_ra];//读取指令 
//always@ (*)
//    case(Instruct)
//         32'h00046401:$display($time,,"当前状态：取指令");
//         32'h00060020:$display($time,,"当前状态：译指令");
//         MC_LEN'h004c0003:$display($time,,"当前状态：LW1");
//         MC_LEN'h00200404:$display($time,,"当前状态：LW2");
//         MC_LEN'h00011000:$display($time,,"当前状态：LW3");
//         MC_LEN'h004c0006:$display($time,,"当前状态：SW1");
//         MC_LEN'h00200800:$display($time,,"当前状态：SW2");
//         MC_LEN'h00080088:$display($time,,"当前状态：R1");
//         MC_LEN'h00009000:$display($time,,"当前状态：BEQ");
//         MC_LEN'h00180240:$display($time,,"当前状态：BNE");
//         MC_LEN'h00180140:$display($time,,"当前状态：ADDI1");
//         MC_LEN'h004c008c:$display($time,,"当前状态：ADD2");
//         MC_LEN'h00001000:$display($time,,"当前状态：SYSCALL");
//         MC_LEN'h00800000:$display($time,,"当前状态：ANDI1");
//         MC_LEN'h000c008f:$display($time,,"当前状态：ANDI2");
//         MC_LEN'h00001000:$display($time,,"当前状态：ADDIU1");
//         MC_LEN'h004c0091:$display($time,,"当前状态：ADDIU1");
//         MC_LEN'h00001000:$display($time,,"当前状态：ADDIU1");
//         MC_LEN'h004c0093:$display($time,,"当前状态：SLTI1");
//        MC_LEN'h00001000:$display($time,,"当前状态：SLTI2");
//        MC_LEN'h000c0095:$display($time,,"当前状态：ORI1");
//        MC_LEN'h00001000:$display($time,,"当前状态：ORI2");
//        MC_LEN'h04000000:$display($time,,"当前状态：JR");
//        MC_LEN'h02000000:$display($time,,"当前状态：J");
//        MC_LEN'h02020019:$display($time,,"当前状态：JAL1");
//        MC_LEN'h04001000:$display($time,,"当前状态：JAL2");
//     endcase


//    always@ (*)
//        case(Instruct)
//             32'h00026401:$display($time,,"当前状态：取指令");
//             32'h00060020:$display($time,,"当前状态：译指令");
//             32'h004c0003:$display($time,,"当前状态：LW1");
//             32'h00200404:$display($time,,"当前状态：LW2");
//             32'h00011000:$display($time,,"当前状态：LW3");
//             32'h004c0006:$display($time,,"当前状态：SW1");
//             32'h00200800:$display($time,,"当前状态：SW2");
//             32'h00080088:$display($time,,"当前状态：R1");
//             32'h00009000:$display($time,,"当前状态：R2");
//             32'h00180240:$display($time,,"当前状态：BEQ");
//             32'h00180140:$display($time,,"当前状态：BNE");
//             32'h004c008c:$display($time,,"当前状态：ADDI1");
//             32'h00001000:$display($time,,"当前状态：ADDI2");
//             32'h00800000:$display($time,,"当前状态：SYSCALL");
//             32'h000c008f:$display($time,,"当前状态：ANDI1");
//             32'h00001000:$display($time,,"当前状态：ANDI2");
//             32'h004c0091:$display($time,,"当前状态：ADDIU1");
//             32'h00001000:$display($time,,"当前状态：ADDIU2");
//             32'h004c0093:$display($time,,"当前状态：SLTI1");
//            32'h00001000:$display($time,,"当前状态：SLTI2");
//            32'h000c0095:$display($time,,"当前状态：ORI1");
//            32'h00001000:$display($time,,"当前状态：ORI2");
//            32'h04002000:$display($time,,"当前状态：JR");
//            32'h02002000:$display($time,,"当前状态：J");
//            32'h02022019:$display($time,,"当前状态：JAL1");
//            32'h01001000:$display($time,,"当前状态：JAL2");
//         endcase
        

         
        //右指令产生控制信号
        assign next_addr=Instruct[4:0];//取出下址
        assign mini_address=next_addr;

        assign P=Instruct[5];//取出地址控制信号 
   
        assign ALU_Control=Instruct[7:6];//取出ALU运算控制信号 
   
        assign {JR,JMP,JAL,Syscall,SignedExt,lorD,PCsrc,AluSrcA,AluSrcB, MemToReg,RegDst,IrWrite,PcWrite,RegWrite,MemWrite,MemRead,Beq,Bne}=Instruct[26:8];//取出控制信号 
       //模块输入输出显示：
//         always@(*)
//         begin
//              $monitor($time,,"微程序信号存储器本次访问地址：ad_ra=%h",ad_ra);
//            $monitor($time,,"取出的微程序信号指令：Instruct=%h",Instruct);
//         end

//        always@(*)
//            $monitor($time,,"下地址：next_addr=%b",next_addr);

//      always@(*)
//            $monitor($time,,"P=%b",P);

//       always@(*)
//            $monitor($time,,"控制器内部：当前状态的运算器信号：ALU_Control=%b",ALU_Control);

//       always@(*)
//         begin
//            $monitor($time,,"控制器内部：当前状态的信号：lorD=%b,PCsrc=%b,AluSrcA=%b,AluSrcB=%b, MemToReg=%b,RegDst=%b,IrWrite=%b,",Instruct[20],Instruct[19],Instruct[18],Instruct[17:16],Instruct[15],Instruct[14],Instruct[13]);
//            $monitor($time,," 控制器内部：PcWrite=%b,RegWrite=%b,MemWrite=%b,MemRead=%b,Beq=%b,Bne=%b",Instruct[12],Instruct[11],Instruct[10],Instruct[9],Instruct[8],Instruct[7]);
//            end
	//#################（ 模块结束）#################//  
 
 
 
 
  //$$$$$$$$$$$$$$$（ ALU控制信号产生  模块）$$$$$$$$$$$$$$$$$$// 
        always@(*)
            case(ALU_Control)
                2'd0: ALU_OP=4'h5;
                2'd1: ALU_OP=4'h6;
                2'd2: ALU_OP=CU_Alu_Mem[CU_address];
                default: ALU_OP=4'h5;
            endcase
	//#################（ 模块结束）#################// 













    
    
    
    
    
    
endmodule
