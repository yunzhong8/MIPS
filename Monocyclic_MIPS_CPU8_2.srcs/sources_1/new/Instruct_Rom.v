`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/30 16:47:18
// Design Name: 
// Module Name: Instruct_Rom
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


module B_Instr_Rom(
input clk,
input[9:0]irom_in_ra,
output [31:0]irom_out_d

    );
    always@(*)
    begin
        $display($time,,"Block_RomÄÚ²¿£ºclk=%h,addra=%h,douta=%h",clk,irom_in_ra,irom_out_d);
        
    end
  s_rom_8_256 your_instance_name (
   .clka(clk),    // input wire clka
  .addra(irom_in_ra),  // input wire [7 : 0] addra
  .douta(irom_out_d)  // output wire [31 : 0] douta
);

endmodule
