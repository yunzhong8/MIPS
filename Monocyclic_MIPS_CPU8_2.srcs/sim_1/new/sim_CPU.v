`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/18 00:34:59
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
    reg clk,rst_l;
    //reg[31:0]PC;
    initial
    begin 
    clk=1'b1;
    rst_l=1'b0;
    #1
    rst_l=1'b1;
    end
    CPU T(clk,rst_l);
    
    always #5  
    clk=~clk;
endmodule
