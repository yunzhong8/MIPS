`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/06 21:53:08
// Design Name: 
// Module Name: sim_Clk_Div
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


module sim_Clk_Div(

    );
    reg sys_clk_in,sys_rst_n;
    wire clk_3;
initial
	begin
		sys_clk_in=1'b1;
		sys_rst_n=1'b0;

		#3sys_rst_n=1'b1;
	end

always#5
	sys_clk_in=~sys_clk_in;

Clk_Div CD(sys_clk_in,sys_rst_n,clk_3);
endmodule
