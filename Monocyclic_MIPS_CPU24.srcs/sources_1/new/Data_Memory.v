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
             end
endmodule

