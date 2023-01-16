`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/30 17:29:39
// Design Name: 
// Module Name: Ram_Data
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


module B_Data_Ram(
input clk,

input dm_in_wre, //在前面用1有效，后的0有效
input wire [9:0] dm_in_rwa,
input wire [31:0] dm_in_wd,

output wire[31:0] dm_out_rd

    );
   parameter ena=1'b1; 
    s_ram_8_256 your_instance_name (
  .clka(clk),    // input wire clka
  .wea(dm_in_wre),      // input wire [0 : 0] wea
  .addra(dm_in_rwa),  // input wire [7 : 0] addra
  .dina(dm_in_wd),    // input wire [31 : 0] dina
  .douta(dm_out_rd)  // output wire [31 : 0] douta
);
endmodule
