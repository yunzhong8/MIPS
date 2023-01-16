`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 20:06:44
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
//ָ��洢������дIR
//���ܣ������ַ���������Ӧ��ַ������
//���룺ָ���ַ 10b��ir_in_a;
//�����ָ�� 32b,ir_out_d;
//�洢��ÿ����λ32λ,��Ԫ�����ǣ�dm_len

   parameter dm_len=38;
   reg [31:0] D_M[dm_len:0];

  always @(*)
  if(!rst_l)//��λ���ڳ�ʼ��ָ��洢�� 
  begin
  $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt",D_M);//����ָ��
  //$readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt",D_M);//����ָ��
  //?
  end
  
  //���ڸ��ݵ�ַȡ��ָ��
   assign ir_out_d=D_M[ir_in_a];
   
endmodule
