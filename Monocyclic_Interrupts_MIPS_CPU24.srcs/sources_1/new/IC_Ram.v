`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/15 21:56:20
// Design Name: 
// Module Name: IC_Ram
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


module IC_Ram(
    input rst_l,
   input  wire npcm_in_rwa,
	input  wire npcm_in_wd,
	input  wire npcm_in_re,
	input wire npcm_in_rw,
	output wire npcm_out_rd
    );
    //��ʱ���и�λ�źŵ�RAM,��д˫�˿ڴ洢��
    
//�����ڵ����ݴ洢�� 
parameter DM_len=150;
reg [31:0]DM_Mem[ DM_len:0];//����洢������

always @(* )//д�����ݴ洢
    begin
        if(!rst_l)//��λ�ź���Чʱ
        ; 
        else   
            begin 
                if(npcm_in_we)//��λ�ź���Чʱ������дָ��
                    DM_Mem[npcm_in_rwa]<= npcm_in_wd;
             end
    end
    
    always@(*)//��������
            begin
                 if(!rst_l)//��λ�ź���Чʱ
                        npcm_out_rd=32'h0000_0000; 
                 else//����дָ��
                 if(npcm_in_rw)
                         npcm_out_rd <= DM_Mem[npcm_in_rwa];
//                 $display("��������ݴ洢�� �ڶ�д�� �洢��Ԫ��ֵDM[80]=%h,DM[81]=%h,DM[82]=%h,DM[83]=%h,DM[84]=%h,DM[85]=%h,DM[86]=%h,DM_Mem[87]=%h"
//                 ,DM_Mem[8'h80],DM_Mem[8'h81],DM_Mem[8'h82],DM_Mem[8'h83],DM_Mem[8'h84],DM_Mem[8'h85],DM_Mem[8'h86],DM_Mem[8'h87]);
             end
endmodule


