`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 15:58:36
// Design Name: 
// Module Name: sin_sign_extender
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


module sin_Sign_Extender(

    );
 reg sign;
wire [31:0]OUT;
sign_extender SE(sign,OUT);
initial
begin
sign=1'b1;
end

always #50
sign=~sign;


endmodule
