`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 15:52:11
// Design Name: 
// Module Name: sin_Instruct_Reg
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


module sin_Instruct_Reg(
    );
    reg A;
    wire [31:0] instruct;
    initial
    begin
    $monitor($time,,"A=%h,instruct=%h",A,instruct);
    rst_l=0;
    #10 rst_1=1'b1;
     A<=10'h10;
     end
    always  #5  
    begin
    A=A+1;
    end

    Instruct_Memory(rst_l,A,instruct);
endmodule
