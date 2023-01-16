`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 20:20:27
// Design Name: 
// Module Name: sim_ Sign_Extender
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


module sim_Sign_Extender(

    );
    reg se_in_sign;
    wire[31:0] se_out_data;
    Sign_Extender SE( se_in_sign, se_out_data
    );
    initial
    se_in_sign=1'b1;
    always #5
    se_in_sign=~se_in_sign;

endmodule
