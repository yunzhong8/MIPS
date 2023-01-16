`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/05 21:38:42
// Design Name: 
// Module Name: sim_B_Instr_Rom
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


module sim_B_Instr_Rom(

    );
    reg sys_clk_in,sys_rst_n;
    reg [9:0]ir_in_a;
    wire [31:0]instruct;
initial
	begin
		sys_clk_in=1'b1;
		sys_rst_n=1'b0;
		ir_in_a=10'h1;

		#3sys_rst_n=1'b1;
		
	end

    initial
		#10 repeat(32)
		  #8ir_in_a=ir_in_a+10'h1;
always#5
	sys_clk_in=~sys_clk_in;

 B_Instr_Rom IR(sys_clk_in,ir_in_a, instruct);

endmodule
