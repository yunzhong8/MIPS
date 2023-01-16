`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 21:40:04
// Design Name: 
// Module Name: Reg
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


module Reg(
input clk,//�Ĵ���ʱ������
input rst_l,//�Ĵ�����λ�ź�
input [31:0]R_in_d,//�Ĵ���д������
input R_e,//�Ĵ���дʹ���ź�

output reg [31:0]R_out_d //�Ĵ����������

    );
 //���ܣ�ʵ�־���ʹ�ܺ͸�λ���ܵ�32λ�Ĵ���
 //*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//
       always@(posedge clk,negedge rst_l)
        if(!rst_l)
             R_out_d<=32'h0;
        else    if(R_e)
                   R_out_d<=R_in_d;
                else
                     R_out_d<=R_out_d;
endmodule
