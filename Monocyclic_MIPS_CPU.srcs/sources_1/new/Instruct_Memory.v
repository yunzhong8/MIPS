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
  if(!rst_l)//��λ���ڳ�ʼ��ָ��洢�� 
  begin
   $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/data.txt",D_M);//����ָ�� 
   end
  
  //���ڸ��ݵ�ַȡ��ָ��
   assign instruct=D_M[A];
   
endmodule