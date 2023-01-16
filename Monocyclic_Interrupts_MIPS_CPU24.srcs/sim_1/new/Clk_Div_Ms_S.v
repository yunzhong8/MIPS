`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/24 15:40:26
// Design Name: 
// Module Name: Clk_Div_Ms_S
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


module Clk_Div_Ms_S(
input clk,
input rst_l,
output  clk_1ms,
output  clk_10ms,
output  clk_100ms,
output  clk_1s,
output clk_10s
);

clk_div_ms  T_1ms(clk,rst_l,clk_1ms);
clk_div10  T_10ms(clk_1ms,rst_l,clk_10ms);
clk_div10  T_100ms(clk_10ms,rst_l,clk_100ms);
clk_div10  T_1s(clk_100ms,rst_l,clk_1s);
clk_div10  T_10s(clk_1s,rst_l,clk_10s);

endmodule

