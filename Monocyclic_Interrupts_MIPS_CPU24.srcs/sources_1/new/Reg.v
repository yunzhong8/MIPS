`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 23:16:03
// Design Name: 
// Module Name: Reg
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


module Reg(
input clk,
input rst_l,
input [31:0]R_in_d,
input R_e,

output reg [31:0]R_out_d

    );
       always@(posedge clk,negedge rst_l)
        if(!rst_l)
             R_out_d<=32'h0;
        else    if(R_e)
                   R_out_d<=R_in_d;
                else
                     R_out_d<=R_out_d;
endmodule
