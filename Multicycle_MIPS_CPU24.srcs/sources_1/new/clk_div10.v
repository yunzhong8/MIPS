`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/13 09:50:33
// Design Name: 
// Module Name: clk_div10
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


module clk_div10
(
input clk,
input rst_l,
output reg clk_10
);
reg [2:0]cnt_4;
parameter CNT_MAX= 3'd4;
//10��Ƶ��
//10��Ƶ����
always @(posedge clk,negedge rst_l)
if(!rst_l)//��λ�ź���Чʱ
cnt_4<=0;//�Լ��������и���ֵ�͸�ԭ
else	if(cnt_4==CNT_MAX)
cnt_4<=0;
else 
cnt_4<=cnt_4+3'd1;
//10clkƵ�ʲ���
always @(posedge clk,negedge rst_l)
if(!rst_l)//��λ�ź���Чʱ
clk_10<=1'b0;
else	if(cnt_4==0)
clk_10<=~clk_10;
else 
clk_10<=clk_10;
endmodule

