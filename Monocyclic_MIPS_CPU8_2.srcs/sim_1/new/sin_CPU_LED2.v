`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 18:59:12
// Design Name: 
// Module Name: sin_CPU_LED2
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


module sin_CPU_LED2(

    );
     reg sys_clk_in,sys_rst_n;
     wire[7:0]  seg_cs_pin,
             seg_data_0_pin,
             seg_data_1_pin;
      initial
             begin
                 sys_clk_in=1'b1;
                 sys_rst_n=1'b0;
                 #3sys_rst_n=1'b1;
             end

         always#5
             sys_clk_in=~sys_clk_in;
             
         CPU_LED CL(
             sys_clk_in, sys_rst_n,
             seg_cs_pin,
             seg_data_0_pin,
             seg_data_1_pin);
endmodule
