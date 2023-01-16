`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 16:02:34
// Design Name: 
// Module Name: sin_ALU
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


module sin_ALU(

    );
    
reg [31:0]A,B;
reg [3:0]S,i;
wire equ;
wire [31:0]R1,R2;
    
    ALU T1
(
A,//参加运算的数A
B,//参加运算的数B
S,//运算功能控制

equ,
R1,//低字节
R2//高字节
);


initial
begin
$monitor($time,,"A=%h,B=%h,S=%b,equ=%b,R1=%h,R2=%h",A,B,S,equ,R1,R2);
A<=32'h48;
B<=32'h53;
S=4'h0;

end
always #5
S<=S+1;
endmodule
