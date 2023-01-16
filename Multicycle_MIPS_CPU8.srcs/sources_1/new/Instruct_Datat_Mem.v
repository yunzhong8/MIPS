`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 20:47:28
// Design Name: 
// Module Name: Instruct_Datat_Mem
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


module Instruct_Datat_Mem(
input clk,//�������洢����ʱ������
input rst_l,//��λ�ź�
input [9:0]idm_in_rwa,//ָ�����ݴ洢���Ķ�д��ַ
input [31:0]idm_in_wd,//ָ�����ݴ洢����д������
input idm_in_we,//ָ�����ݴ洢����д��ʹ���ź� 
input idm_in_re,//ָ�����ݴ洢���Ķ���ʹ���ź�

output reg[31:0]idm_out_rd//ָ�����ݴ洢���Ķ�����
    );
//���ܣ���ʱ�������ظ���дʹ�ܺͶ�ʹ�ܣ�������ַ��Ӧ������,��д���ַ��Ӧ�Ŀռ�
 //*******************************************Define Inner Variable�������ڲ�������***********************************************//
	 parameter IDM_LEN=138;
    reg[31:0]ID_Mem[IDM_LEN:0];
    reg [5:0]i=6'h0;

 //*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//
     //$$$$$$$$$$$$$$$��д���� ģ����ã�$$$$$$$$$$$$$$$$$$// 
        always@(posedge clk,negedge rst_l)//д����
            if(!rst_l)
           ;
            else    if(idm_in_we)//���ݶ�дʹ���źţ���д����
                        ID_Mem[idm_in_rwa]<=idm_in_wd;
  
	//#################�� ģ�������#################// 
	
	
	
	//$$$$$$$$$$$$$$$�������� ģ�飩$$$$$$$$$$$$$$$$$$// 
	    always@(*)
            if(!rst_l)
                begin
                    $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt",ID_Mem);
//                  $display("��ʼ��ָ��洢");
//                  repeat(39)
//                    begin
//                        $display("ID_Mem[%h]=%h",i,ID_Mem[i]);
//                        i=i+6'h1;
//                     end
                end
           else  if(idm_in_re)
                        begin
                            idm_out_rd<=ID_Mem[idm_in_rwa];
//                          $display($time,,"������ݴ洢��Ӧλ�õ�ֵ");
//                          $display("DM[80]=%h,DM[81]=%h,DM[82]=%h,DM[83]=%h,DM[84]=%h,DM[85]=%h,DM[86]=%h,DM_Mem[87]=%h"
//                                    ,ID_Mem[8'h80],ID_Mem[8'h81],ID_Mem[8'h82],ID_Mem[8'h83],ID_Mem[8'h84],ID_Mem[8'h85],ID_Mem[8'h86],ID_Mem[8'h87]);
                         end
                  else
                        idm_out_rd<=idm_out_rd;
	//#################�� ģ�������#################//
endmodule
