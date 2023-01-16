`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 21:53:36
// Design Name: 
// Module Name: sin_Ring_Shift_LR
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


module sin_Ring_Shift_LR(

    );
    reg [31:0]I;
    reg [3:0]n;
    reg r_or_l;
    wire [31:0]R;
    initial
    begin
    I=32'h0000_000f;
    n=4'h2;
    r_or_l=1'b1;
    #5 
    r_or_l=1'b0;
    end
    Ring_Shift_LR RSLR(I, n,
 r_or_l,R
    );
    
endmodule
