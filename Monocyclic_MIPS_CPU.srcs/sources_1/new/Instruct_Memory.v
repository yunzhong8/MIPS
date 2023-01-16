`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 10:59:40
// Design Name: 
// Module Name: Instruct_Memory
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


module Instruct_Memory(
input rst_l,
input [9:0]A,
output [31:0]instruct
    );
   reg [31:0] D_M[38:0];
  always @(*)
  if(!rst_l)//复位用于初始化指令存储器 
  begin
   $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/data.txt",D_M);//保存指令 
   end
  
  //用于根据地址取出指令
   assign instruct=D_M[A];
   
endmodule