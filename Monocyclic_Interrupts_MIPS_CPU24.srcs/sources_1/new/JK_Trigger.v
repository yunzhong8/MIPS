`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/07 23:20:09
// Design Name: 
// Module Name: JK_Trigger
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


module JK_Trigger(
input clk,
input jkt_in_j,
input jkt_in_k,
output reg jkt_out_q

    );
    always@(posedge clk)
        case({jkt_in_j,jkt_in_k})
            2'd0:jkt_out_q<=jkt_out_q;
            2'd1:jkt_out_q<=1'b0;
            2'd2:jkt_out_q<=1'b1;
            2'd3:jkt_out_q<=~jkt_out_q;
        endcase
endmodule
