`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/11 11:29:26
// Design Name: 
// Module Name: ALU
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


module ALU
(
input [31:0]A,//�μ��������A
input [31:0]B,//�μ��������B
input [3:0]S,//���㹦�ܿ���

output reg equ,
output reg [31:0]R1,//���ֽ�
output reg [31:0]R2//���ֽ�

);

reg LR;
reg [31:0]Temp_A;
always @(A,B,S,Temp_A)
case(S)
4'b0000:R1<=A<<B[3:0];//0����
4'b0001:
        begin
        LR=1;
        R1<=Temp_A;
end//1ѭ������
4'b0010:R1<=A>>B[3:0];//2����
4'b0011:{R2,R1}<=A*B;//3�˷�
4'b0100:{R2,R1}<=A/B;//4����
4'b0101:R1<=A+B;//5�ӷ�
4'b0110:R1<=A-B;//6����
4'b0111:R1<=A&B;//7and
4'b1000:R1<=A|B;//8OR
4'b1001:R1<=A^B;//9XOR
4'b1010:R1<=A^~B;//aNOR
4'b1011:
        if(A==B)//b���
        equ<=1'b1;
4'b1100:
        if(A!=B)//c�����
        equ<=1'b0;
4'b1101:;//d
4'b1110:;//e 
4'b1111:;//f
endcase
Ring_Shift_LR T1(Temp_A,B[3:0],LR);
Ring_Shift_LR T2(Temp_A,B[3:0],LR);




endmodule
