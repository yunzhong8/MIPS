`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/07 23:00:28
// Design Name: 
// Module Name: Interrupt_Contruct
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


module Interrupt_Contruct(
input clk,
input rst_l,
input [7:0]icus_in_Interr_sign,//�����ж��ź�
input [31:0]icus_in_next_pc,//���뵱ǰָ�����һ��ָ���PCֵ
input icus_in_eret,//�����жϽ����ź�

output reg icus_out_int,//����ж���ָ����ź�
output [31:0]icus_out_Interr_a,//����ж��ӳ����ַ
output [31:0]icus_out_next_pc,//����жϷ���ʱ���PCֵ
output reg[16:0] icus_out_ld//�ж�ָʾ�ƿ����ź�
);
//�жϿ������������ж��ź����룬ִ���ж�

 //*******************************************Define Inner Variable�������ڲ�������***********************************************//

	reg IE=0;//�жϱ�ǣ�1��ʾ���жϣ��������ж�.0��ʾ���жϣ������ж�
	reg [7:0]now_pr;//�洢��ǰ�жϵ����ȼ������ж�������ķ��ʵ�ַ������ʾ�жϸ�λ�Ĵ���
	//�����жϼ�����
	reg [7:0]ICR=8'h0;
	//��ջ�洢��
	wire npcm_in_rwa;
	wire npcm_in_wd;
	wire npcm_in_re;
	wire npcm_in_rw;
	wire npcm_out_rd;

	
//*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//
	//�ж�����Ĵ���
		reg[7:0]IRR=8'b0000_0000;
		always@(*)
			IRR=IRR|icus_in_interr_sign;
	//�ж����μĴ���:Ҫ���ε�������Ϊ1
		reg [7:0]IMR;
	//���ȼ��ж�PR
		assign pr_in_d=~IMR&IRR;
	    Priority_Resolver	PR(pr_in_d,pr_out_d);
	

	//INT�źŲ�����ִ���ж���ָ��
		always@(posedge clk,negedge rst_l)
			if(rst_l);

			else
				if(!IE&&(pr_out_d>8'h0))//if�жϴ򿪣��ж�����Ĵ�����ֵ��������ж���ָ��
					begin
						icus_out_int<=1'b1;
						now_pr<=pr_out_d;//��ȡǰһ�������ȶ��õ��ж�Դ
						icus_out_ld[now_pr]<=1'b1;//���ڷ��ʵ��ж�Դ��Ӧ��led��������
						icus_out_ld[7:0]=pr_in_d;//��������ж�Դ��Ӧ�ĵƶ�������
						ICR<=ICR+8'h1;//�ж�����+1
					end

				else
					icus_out_int<=1'b0;
					
	//IE�źſ���
		always@(icus_out_int,icus_in_eret)
			begin
				if(icus_out_int==1'b1)//�ж���ָ���źŲ��������ù��ж�
					IE<=1'b1;
				else//���򱣳ֲ���
					IE<=IE;

				if(icus_in_eret&&ICR>8'h1)//�жϷ����źŲ�����ͬʱ�ж�����>1,���жϲ������ж�����-1
					begin
						IE<=IE;
						ICR<=ICR-8'h1;
					end	
				else	if(icus_in_eret&&ICR==8'h1)//�жϷ����źŲ������ж�����=1���ж�,�ж�����Ϊ0
						begin
							IE<=1'b0;
							ICR<=8'h0;
						end
					else//�ж��ź�δ������IE���䣬�ж���������
						begin
							IE<=IE;
							ICR<=ICR;
						end
			end
			
			
	//ִ���ж�ʱ�����ж�
		always @(posedge clk,negedge rst_l)
			if(!rst_l)
			;
			else	if(IE==1'b1&&now_pr<pr_out_d)//if�жϹرգ�ͬʱ���ж����ȼ�>��ǰִ���ж����ȼ�,���ж�
					   IE<=1'b0	;
				    else
					   IE<=IE;
	//�����ֳ�,�ͻ�ԭ�ֳ�
		reg [7:0]Top;//ջ����ջ��ʼ��ָ��δ�����������ݵĿռ�
		assign npcm_in_rwa=Top;
		assign npcm_in_re=icus_out_int;
		assign npcm_in_we=icus_in_eret;
		assign npcm_in_wd=icus_in_next_pc;
		IC_Ram NPCM(npcm_in_rwa,npcm_in_wd,npcm_in_re,npcm_in_we,npcm_out_rd);

		always@(negedge icus_out_int)//���ж���ָ������󣬼�PC+4��ַ��������޸�ջ��+1
			Top<=Top+8'h1;
		always@(posedge icus_in_eret)//���жϽ����źŲ���ʱ���޸�ջ��-1,��֤���жϷ���ָ����������������ȷ��PC+4;
			Top<=Top-8'h1;
		assign icus_out_next_pc=npcm_out_rd;
         
             
     
endmodule
