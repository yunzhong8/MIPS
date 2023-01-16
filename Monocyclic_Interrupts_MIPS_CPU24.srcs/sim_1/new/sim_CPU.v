`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/24 10:39:52
// Design Name: 
// Module Name: sim_CPU
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


module sim_CPU(

    );
    reg Go;
   

reg sys_clk_in,sys_rst_n;
initial
    begin
        sys_clk_in=1'b1;
        sys_rst_n=1'b0;
        Go<=1'b0;
        
        #3sys_rst_n=1'b1;
    end

always#5
    sys_clk_in=~sys_clk_in;


 wire [31:0]LED_DATA;
    CPU T1(
        sys_clk_in,
        sys_rst_n,
        Go,
        LED_DATA
    //output PC
            );


endmodule
