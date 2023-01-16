`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 22:20:25
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
input [9:0]ir_in_a,
output [31:0] ir_out_d
    );
//指令存储器，缩写IR
//功能：输入地址即可输出对应地址的数据
//输入：指令地址 10b，ir_in_a;
//输出：指令 32b,ir_out_d;
//存储器每个单位32位,单元个数是：dm_len

   parameter dm_len=244;
   reg [31:0] D_M[dm_len:0];
   reg [6:0] i=7'h0;
  always @(*)
  if(!rst_l)//复位用于初始化指令存储器 
      begin
          $readmemh("D:/Documents/Hardware_verlog/Source_Data/Monocyclic_Interrupt_MIPS_CPU24/IR_Data.txt",D_M);//保存指令
//          $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt",D_M);//保存指令
 
      end
  
  //用于根据地址取出指令
   assign ir_out_d=D_M[ir_in_a];
   
endmodule
