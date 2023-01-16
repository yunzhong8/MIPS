`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 15:51:33
// Design Name: 
// Module Name: sin_CPU
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


module sin_CPU (

    );  
    reg sys_clk_in,sys_rst_n;
     CPU T1(
     sys_clk_in, sys_rst_n
);
initial
begin
sys_clk_in=0;
sys_rst_n=0;
#12 sys_rst_n=1;
end
always #5 sys_clk_in=~sys_clk_in;
endmodule
