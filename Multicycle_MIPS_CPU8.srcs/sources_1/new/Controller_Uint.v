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
    //������������ڰ�as_in_instrд��Ϊad_in_instr����������� �����˰��� 
    //��ַת����Ҳд���ˣ�ԭ���������������Ӧ��ϵ���� 
//*******************************************Define Inner Variable�������ڲ�������***********************************************//
    reg LW=1'b0,SW=1'b0,BEQ=1'b0,BNE=1'b0,ADDI=1'b0,R=1'b0;
    reg ADD=1'b0,SLT=1'b0,SysCall=1'b0;
    wire R_TYPE;
      
    //��ַת����
    wire [6:0]as_in_instr;//��ַת����������
    wire [3:0]as_out_address;//��ַת�Ƶ����
    
    //ָ����ƴ洢��
    reg [20:0]Addr_Mem[15:0];
    wire[3:0] next_addr;//ָ�����ַ
    reg [3:0]ad_ra;//���ƴ洢���ķ��ʵ�ַ
    wire [20:0]Instruct;
    
    //��ַ�����ź� 
    wire P;
    
    //ALU�����ź�
    wire [1:0]ALU_Control;
    ////////////////////////////////////logic implementation
//    always@(*)
//        $monitor($time,,"����������ģ�Op=%h,Func=%h",Op,Func);
//*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//
  //ʶ��Lָ�������ָ��ָ������
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
             case(Func)//ʶ������ָ���У�R�ͣ�J�ͣ�Syscall
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
    
    
    
    //ALU�����źŲ��� 
    always@(*)
        case(ALU_Control)
            2'b00:ALU_OP<=4'd5;
            2'b01:ALU_OP<=4'd6;
            2'b10:ALU_OP<=(Func==6'h2a)?4'hb:4'h5;
        endcase
   
    
    //��ַת����
     assign as_in_instr ={(ADD|SLT)&~SysCall,ADDI,LW,SW,BEQ,BNE,SysCall};
//    always @(ADD,SLT,SysCall,ADDI,LW,SW,BEQ,BNE,SysCall)
//    begin
//        $display($time,,"��ǰ״̬��Ӧ��ָ�RType=%h,ADDI=%h,LW=%h,SW=%h,BEQ=%h,BNE=%h,SysCall=%h",(ADD|SLT)&~SysCall,ADDI,LW,SW,BEQ,BNE,SysCall);
//        $display($time,,"��ַת���������룺ad_in_instr=%h",as_in_instr);
//    end
    Address_Shift AS(as_in_instr,as_out_address);
//    always@(*)
//         $display($time,,"��ַת�����������as_out_address=%h",as_out_address);
   
    //�źŴ洢��
    reg [3:0]i=4'h0;
    always@(posedge clk,negedge rst_l)
        if(!rst_l)//��ʼ���źŴ洢����ַΪ0
            begin
            $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Monocyclic_MIPS_CPU8_2/Mem_data/CU_Mem.txt",Addr_Mem);
            ad_ra<=4'h0;
            i<=4'h0;
//            $display("��ʼ��΢����洢���ڱ���ָ��ֵ");
//            repeat(16)
//                begin
//                    $display("Addr_Mem[%d]=%h",i,Addr_Mem[i]);
//                     i=i+4'h1;
//                end
            end
        else    if(P)//PΪ1,Ϊ��ָ��ȡ����ָ���Ӧ���źŴ洢����ַ
                 ad_ra<=as_out_address;
            else//PΪ0ʱ���źŴ洢����ַΪָ����ַ
                 ad_ra<=next_addr;
    assign Instruct=Addr_Mem[ad_ra];//��ȡָ�� 
//     always@(*)
//     begin
//          $monitor($time,,"΢�����źŴ洢�����η��ʵ�ַ��ad_ra=%h",ad_ra);
//        $monitor($time,,"ȡ����΢�����ź�ָ�Instruct=%h",Instruct);
//     end
     
    //��ָ����������ź�
    assign next_addr=Instruct[3:0];//ȡ����ַ
    assign mini_address=next_addr;
//    always@(*)
//        $monitor($time,,"�µ�ַ��next_addr=%b",next_addr);
    assign P=Instruct[4];//ȡ����ַ�����ź� 
//     always@(*)
//        $monitor($time,,"P=%b",P);
    assign ALU_Control=Instruct[6:5];//ȡ��ALU��������ź� 
//      always@(*)
//        $monitor($time,,"�������ڲ�����ǰ״̬���������źţ�ALU_Control=%b",ALU_Control);
    assign {lorD,PCsrc,AluSrcA,AluSrcB, MemToReg,RegDst,IrWrite,PcWrite,RegWrite,MemWrite,MemRead,Beq,Bne}=Instruct[20:7];//ȡ�������ź� 
//     always@(*)
//     begin
//        $monitor($time,,"�������ڲ�����ǰ״̬���źţ�lorD=%b,PCsrc=%b,AluSrcA=%b,AluSrcB=%b, MemToReg=%b,RegDst=%b,IrWrite=%b,",Instruct[20],Instruct[19],Instruct[18],Instruct[17:16],Instruct[15],Instruct[14],Instruct[13]);
//        $monitor($time,," �������ڲ���PcWrite=%b,RegWrite=%b,MemWrite=%b,MemRead=%b,Beq=%b,Bne=%b",Instruct[12],Instruct[11],Instruct[10],Instruct[9],Instruct[8],Instruct[7]);
//        end













    
    
    
    
    
    
endmodule
