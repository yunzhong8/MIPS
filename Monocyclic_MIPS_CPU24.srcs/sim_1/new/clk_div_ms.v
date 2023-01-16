`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/24 15:41:34
// Design Name: 
// Module Name: clk_div_ms
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


module clk_div_ms
#(parameter CNT_MAX= 16'd49999)
(
input clk,
input rst_l,
output reg clk_1ms
);
reg [15:0]cnt_1ms;

//Ĭ�϶�100MƵ�ʼ�10ns clkת1ms����
always @(posedge clk,negedge rst_l)
if(!rst_l)//��λ�ź���Чʱ
cnt_1ms<=0;//�Լ��������и���ֵ�͸�ԭ
else	if(cnt_1ms==CNT_MAX)
cnt_1ms<=0;
else 
cnt_1ms<=cnt_1ms+15'd1;
//1msƵ�ʲ���
always @(posedge clk,negedge rst_l)
if(!rst_l)//��λ�ź���Чʱ
clk_1ms<=1'b0;
else	if(cnt_1ms==0)
clk_1ms<=~clk_1ms;
else 
clk_1ms<=clk_1ms;

endmodule


