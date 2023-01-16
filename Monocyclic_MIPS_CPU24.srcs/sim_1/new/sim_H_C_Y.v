`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/31 15:08:35
// Design Name: 
// Module Name: sim_H_C_Y
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


module sim_H_C_Y(

    );
    wire [7:0]seg_cs_pin;
    wire [7:0]seg_data_0_pin;
    wire [7:0]seg_data_1_pin;
    
    reg sys_clk_in,sys_rst_n;
initial
	begin
		sys_clk_in=1'b1;
		sys_rst_n=1'b0;

		#3sys_rst_n=1'b1;
	end

always  #5
	sys_clk_in=~sys_clk_in;

    
     H_C_Y HCY(
      sys_clk_in,
      sys_rst_n,
      seg_cs_pin,
      seg_data_0_pin,
      seg_data_1_pin
    );
endmodule
