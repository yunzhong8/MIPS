`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 20:25:23
// Design Name: 
// Module Name: sim_Instruct_Memory
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


module sim_Instruct_Memory(

    );
    reg rst_l;
    reg [9:0]ir_in_a;
    wire [31:0]ir_out_d;
    Instruct_Memory IM(
 rst_l,ir_in_a,ir_out_d
    );
    initial
    begin
    rst_l=1'b0;
    #5 rst_l=1'b1;
    #5 ir_in_a=10'h0;
    end
    always #15
    ir_in_a<=ir_in_a+10'h1;
    
endmodule
