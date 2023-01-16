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
input [7:0]icus_in_Interr_sign,//输入中断信号
input [31:0]icus_in_next_pc,//输入当前指令的下一条指令的PC值
input icus_in_eret,//输入中断结束信号

output reg icus_out_int,//输出中断隐指令的信号
output [31:0]icus_out_Interr_a,//输出中断子程序地址
output [31:0]icus_out_next_pc,//输出中断返回时候的PC值
output reg[16:0] icus_out_ld//中断指示灯控制信号
);
//中断控制器，根据中断信号输入，执行中断

 //*******************************************Define Inner Variable（定义内部变量）***********************************************//

	reg IE=0;//中断标记，1表示关中断，不允许中断.0表示开中断，允许中断
	reg [7:0]now_pr;//存储当前中断的优先级（即中断向量表的访问地址），表示中断复位寄存器
	//几重中断计数器
	reg [7:0]ICR=8'h0;
	//堆栈存储器
	wire npcm_in_rwa;
	wire npcm_in_wd;
	wire npcm_in_re;
	wire npcm_in_rw;
	wire npcm_out_rd;

	
//*******************************************loginc Implementation（程序逻辑实现）***********************************************//
	//中断请求寄存器
		reg[7:0]IRR=8'b0000_0000;
		always@(*)
			IRR=IRR|icus_in_interr_sign;
	//中断屏蔽寄存器:要屏蔽的则设置为1
		reg [7:0]IMR;
	//优先级判断PR
		assign pr_in_d=~IMR&IRR;
	    Priority_Resolver	PR(pr_in_d,pr_out_d);
	

	//INT信号产生，执行中断隐指令
		always@(posedge clk,negedge rst_l)
			if(rst_l);

			else
				if(!IE&&(pr_out_d>8'h0))//if中断打开，中断请求寄存器有值，则进入中断隐指令
					begin
						icus_out_int<=1'b1;
						now_pr<=pr_out_d;//获取前一个周期稳定好的中断源
						icus_out_ld[now_pr]<=1'b1;//正在访问的中断源对应的led灯设置亮
						icus_out_ld[7:0]=pr_in_d;//待处理的中断源对应的灯都亮起来
						ICR<=ICR+8'h1;//中断重数+1
					end

				else
					icus_out_int<=1'b0;
					
	//IE信号控制
		always@(icus_out_int,icus_in_eret)
			begin
				if(icus_out_int==1'b1)//中断隐指令信号产生则设置关中断
					IE<=1'b1;
				else//否则保持不变
					IE<=IE;

				if(icus_in_eret&&ICR>8'h1)//中断返回信号产生后同时中断重数>1,则中断不开，中断重数-1
					begin
						IE<=IE;
						ICR<=ICR-8'h1;
					end	
				else	if(icus_in_eret&&ICR==8'h1)//中断返回信号产生后：中断重数=1则开中断,中断重数为0
						begin
							IE<=1'b0;
							ICR<=8'h0;
						end
					else//中断信号未产生则：IE不变，中断重数不变
						begin
							IE<=IE;
							ICR<=ICR;
						end
			end
			
			
	//执行中断时又来中断
		always @(posedge clk,negedge rst_l)
			if(!rst_l)
			;
			else	if(IE==1'b1&&now_pr<pr_out_d)//if中断关闭，同时新中断优先级>当前执行中断优先级,则开中断
					   IE<=1'b0	;
				    else
					   IE<=IE;
	//保护现场,和还原现场
		reg [7:0]Top;//栈顶，栈顶始终指向未存入输入数据的空间
		assign npcm_in_rwa=Top;
		assign npcm_in_re=icus_out_int;
		assign npcm_in_we=icus_in_eret;
		assign npcm_in_wd=icus_in_next_pc;
		IC_Ram NPCM(npcm_in_rwa,npcm_in_wd,npcm_in_re,npcm_in_we,npcm_out_rd);

		always@(negedge icus_out_int)//在中断隐指令结束后，即PC+4地址存入后再修改栈顶+1
			Top<=Top+8'h1;
		always@(posedge icus_in_eret)//在中断结束信号产生时，修改栈顶-1,保证再中断返回指令周期中完成输出正确的PC+4;
			Top<=Top-8'h1;
		assign icus_out_next_pc=npcm_out_rd;
         
             
     
endmodule
