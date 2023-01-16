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
//单周期的数据存储器 
reg [31:0]DM[144:0];//定义存储器主体

always @(posedge clk,negedge rst_l )
begin
$monitor("1111%h",DM[8'h80]);
if(!rst_l)//复位信号有效时
; 
else    if(str)//复位信号无效时，发出写指令
DM[A]<=in_D;
else//发出写指令
out_D<=DM[A];
end
endmodule

