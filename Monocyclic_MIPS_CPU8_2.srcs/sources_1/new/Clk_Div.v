`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/06 21:46:00
// Design Name: 
// Module Name: Clk_Div
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


module Clk_Div
#(
parameter CNT_BIT=5'd5,
parameter CNT_MAX=5'd2
 )
(
input cd_in_clk,
input rst,
output reg cd_out_clk
);

reg [CNT_BIT:0]cnt;
always@(posedge cd_in_clk,negedge rst)
	if(!rst)
		cnt<=0;
	else	if(cnt==CNT_MAX)
			cnt<=0;			
		else
			cnt<=cnt+1;

always@(posedge cd_in_clk,negedge rst)
	if(!rst)
		cd_out_clk<=1'h0;
	else	if(cnt==0)
			cd_out_clk<=~cd_out_clk;
		else
			cd_out_clk<=cd_out_clk;
endmodule