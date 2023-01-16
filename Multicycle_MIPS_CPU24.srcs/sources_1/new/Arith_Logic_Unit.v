`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 18:48:26
// Design Name: 
// Module Name: Arith_Logic_Unit
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


module Arith_Logic_Unit
(
input rst_l,

input [31:0]alu_in_a,//�μ��������A
input [31:0]alu_in_b,//�μ��������B
input [4:0]alu_in_shamt,
input [3:0]alu_in_contr,//���㹦�ܿ���

output reg alu_out_equ,
output reg [31:0] alu_out_rl,//���ֽ�
output reg [31:0] alu_out_rh//���ֽ�

);
//��дALU
//����32λ�Ĳμ������A��B��4λ��������Ŀ��� alu_in_contr
//���������64λ����Ϊ2��32λ�������

reg LR;
wire [31:0]Temp_A;
always @(alu_in_a,alu_in_b,alu_in_contr,Temp_A,rst_l)
if(!rst_l)
begin
alu_out_equ=1'b0;
alu_out_rh=32'h0;
alu_out_rl=32'h0;
end
else
begin
alu_out_equ<=(alu_in_a==alu_in_b)? 1'b1 :1'b0;
case(alu_in_contr)
4'b0000:alu_out_rl<=alu_in_b<<alu_in_shamt;//0����
4'b0001:
        begin
        LR=1;
       alu_out_rl<=Temp_A;
end//1ѭ������
4'b0010:alu_out_rl<=alu_in_b>>alu_in_shamt;//2����


4'b0011:{alu_out_rh,alu_out_rl}<=alu_in_a*alu_in_b;//3�˷�
4'b0100:{alu_out_rh,alu_out_rl}<=alu_in_a/alu_in_b;//4����
4'b0101:{alu_out_rh,alu_out_rl}<=alu_in_a+alu_in_b;//5�ӷ�
4'b0110:alu_out_rl<=alu_in_a-alu_in_b;//6����
4'b0111:alu_out_rl<=alu_in_a&alu_in_b;//7and
4'b1000:alu_out_rl<=alu_in_a|alu_in_b;//8OR
4'b1001:alu_out_rl<=alu_in_a^alu_in_b;//9XOR
4'b1010:alu_out_rl<=alu_in_a^~alu_in_b;//aNOR
4'b1011:
       if(alu_in_a>alu_in_b)//c�����
            alu_out_rl<=32'h0;
        else
            alu_out_rl<=32'h1;
4'b1100:
        if(alu_in_a>alu_in_b)//c�����
            alu_out_rl<=32'h0;
        else
            alu_out_rl<=32'h1;
4'b1101:;//d
4'b1110:;//e 
4'b1111:;//f
endcase
end
Ring_Shift_LR T1(alu_in_b,alu_in_shamt,LR,Temp_A);
Ring_Shift_LR T2(alu_in_b,alu_in_shamt,LR,Temp_A);




endmodule




