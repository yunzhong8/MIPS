`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/11 12:43:45
// Design Name: 
// Module Name: controller
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
//��Ϊû���������λ���´���

module controller(
input  [5:0]Op,
input [5:0]Func,

output wire Halt,
output wire MemtoReg,
output wire MemWrite,
output wire Beq,
output wire Bne,
output reg AluOP,
output wire AluSrcB,
output wire RegWrite,
output wire RegDst
    );
    
    reg LW,SW,BEQ,BNE,ADDI,R;
    reg ADD,SLT,SysCall;
    wire R_TYPE;
    
    //ʶ��Lָ�������ָ��ָ������
    always @(*)
    case(Op)
    6'h23: LW<=1'b1;
    6'h2b: SW<=1'b1;
    6'h04: BEQ<=1'b1;
    6'h05: BNE<=1'b1;
    6'h08: ADDI<=1'b1;
    6'h00:R<=1'b1;
    endcase
    
    //ʶ������ָ���У�R�ͣ�J�ͣ�Syscall
     always @(Func)
     if(R==1'b1)
    case(Func)
    6'h20:ADD<=1'b1;
    6'h2a:SLT<=1'b1;
    8'h0c:SysCall<=1'b1;
    endcase
    
    assign R_TYPR=ADD|SLT;
    
    //AluOP����
    always@(*)
    case((R)&&(Func==6'h2a))
    1'b0:AluOP<=4'h5;
    1'b1:AluOP<=4'hc;
    endcase
    
    //�����źŲ���
    assign RegDst=R_TYPE;
    assign RegWrite=LW|LW|R_TYPE;
    assign MemtoReg=LW;
    assign MemWrite=SW;
    assign AluSrcB=SW|LW|ADDI;
    assign Beq=BEQ;
    assign Bne=BNE;
    assign Halt=SysCall;
    
endmodule
