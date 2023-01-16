`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 22:21:11
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

input dm_in_wre, //��ǰ����1��Ч�����0��Ч
input wire [9:0] dm_in_rwa,
input wire [31:0] dm_in_wd,


output reg[31:0] dm_out_rd
);
//�����ڵ����ݴ洢�� 
parameter DM_len=150;
reg [31:0]DM_Mem[ DM_len:0];//����洢������

always @(posedge clk,negedge rst_l )//д�����ݴ洢
    begin
        if(!rst_l)//��λ�ź���Чʱ
        ; 
        else   
            begin 
                if(dm_in_wre)//��λ�ź���Чʱ������дָ��
                    DM_Mem[dm_in_rwa]<= dm_in_wd;
             end
    end
    
    always@(*)//��������
            begin
                 if(!rst_l)//��λ�ź���Чʱ
                        dm_out_rd=32'h0000_0000; 
                 else//����дָ��
                         dm_out_rd <= DM_Mem[dm_in_rwa];
//                 $display("��������ݴ洢�� �ڶ�д�� �洢��Ԫ��ֵDM[80]=%h,DM[81]=%h,DM[82]=%h,DM[83]=%h,DM[84]=%h,DM[85]=%h,DM[86]=%h,DM_Mem[87]=%h"
//                 ,DM_Mem[8'h80],DM_Mem[8'h81],DM_Mem[8'h82],DM_Mem[8'h83],DM_Mem[8'h84],DM_Mem[8'h85],DM_Mem[8'h86],DM_Mem[8'h87]);
             end
endmodule

