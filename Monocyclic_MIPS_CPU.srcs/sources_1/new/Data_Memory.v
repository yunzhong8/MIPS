`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 11:00:01
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
input clk,
input rst_l,

input str, 
input wire [9:0] A,
input [31:0]in_D,


output reg[31:0] out_D
);
//�����ڵ����ݴ洢�� 
reg [31:0]DM[144:0];//����洢������

always @(posedge clk,negedge rst_l )
begin
$monitor("1111%h",DM[8'h80]);
if(!rst_l)//��λ�ź���Чʱ
; 
else    if(str)//��λ�ź���Чʱ������дָ��
DM[A]<=in_D;
else//����дָ��
out_D<=DM[A];
end
endmodule

