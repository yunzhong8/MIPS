`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/04 23:01:10
// Design Name: 
// Module Name: D_Data_Ram
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


module D_Data_Ram(
input clk,

input dm_in_wre, //在前面用1有效，后的0有效
input wire [9:0] dm_in_rwa,
input wire [31:0] dm_in_wd,

output wire[31:0] dm_out_rd

    );
    d_s_ram_8_256 your_instance_name (
  .a(dm_in_rwa),      // input wire [9 : 0] a
  .d(dm_in_wd),      // input wire [31 : 0] d
  .clk(clk),  // input wire clk
  .we(dm_in_wre),    // input wire we
  .spo(dm_out_rd)  // output wire [31 : 0] spo
);
endmodule
