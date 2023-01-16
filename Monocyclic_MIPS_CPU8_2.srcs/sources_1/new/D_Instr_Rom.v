`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/04 22:58:38
// Design Name: 
// Module Name: D_Instr_Rom
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


module D_Instr_Rom(
input [9:0]ir_in_a,
output [31:0] ir_out_d

    );
    B_s_rom your_instance_name (
  .a(ir_in_a),      // input wire [9 : 0] a
  .spo(ir_out_d)  // output wire [31 : 0] spo
);

endmodule
