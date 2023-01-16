`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 10:41:42
// Design Name: 
// Module Name: RegFile
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


module RegFile(
input clk,
input rst_l,
input [4:0]R1_A,//�������ݵĵ�ַ
input [4:0]R2_A,//

input write_enable,//дʹ���ź�
input [4:0]W_A,// д�����ݵĵ�ַ
input [31:0]W_D,//д������

output reg[31:0]R1,//�����Ĵ����������
output reg[31:0]R2
    );
    
    reg[31:0] RF[4:0];//�Ĵ�������
    always @(posedge clk ,negedge rst_l)
    if(!rst_l)//��λ
    ;
    else    if(write_enable)//����д������ʱ
    RF[W_A]<=W_D;
    else//���Ƕ�ȡ����ʱ
    begin
    R1<=RF[R1_A];//��ȡR1
    R2=RF[R2_A];//��ȡR2
    end
endmodule
