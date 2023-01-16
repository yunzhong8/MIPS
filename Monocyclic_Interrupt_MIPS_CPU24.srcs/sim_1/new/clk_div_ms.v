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

//默认对100M频率即10ns clk转1ms计数
always @(posedge clk,negedge rst_l)
if(!rst_l)//复位信号有效时
cnt_1ms<=0;//对计数器进行赋初值和复原
else	if(cnt_1ms==CNT_MAX)
cnt_1ms<=0;
else 
cnt_1ms<=cnt_1ms+15'd1;
//1ms频率产生
always @(posedge clk,negedge rst_l)
if(!rst_l)//复位信号有效时
clk_1ms<=1'b0;
else	if(cnt_1ms==0)
clk_1ms<=~clk_1ms;
else 
clk_1ms<=clk_1ms;

endmodule


