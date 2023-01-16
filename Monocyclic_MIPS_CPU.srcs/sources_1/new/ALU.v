`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/11 11:29:26
// Design Name: 
// Module Name: ALU
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


module ALU
(
input [31:0]A,//参加运算的数A
input [31:0]B,//参加运算的数B
input [3:0]S,//运算功能控制

output reg equ,
output reg [31:0]R1,//低字节
output reg [31:0]R2//高字节

);

reg LR;
reg [31:0]Temp_A;
always @(A,B,S,Temp_A)
case(S)
4'b0000:R1<=A<<B[3:0];//0左移
4'b0001:
        begin
        LR=1;
        R1<=Temp_A;
end//1循环右移
4'b0010:R1<=A>>B[3:0];//2右移
4'b0011:{R2,R1}<=A*B;//3乘法
4'b0100:{R2,R1}<=A/B;//4除法
4'b0101:R1<=A+B;//5加法
4'b0110:R1<=A-B;//6减法
4'b0111:R1<=A&B;//7and
4'b1000:R1<=A|B;//8OR
4'b1001:R1<=A^B;//9XOR
4'b1010:R1<=A^~B;//aNOR
4'b1011:
        if(A==B)//b相等
        equ<=1'b1;
4'b1100:
        if(A!=B)//c不相等
        equ<=1'b0;
4'b1101:;//d
4'b1110:;//e 
4'b1111:;//f
endcase
Ring_Shift_LR T1(Temp_A,B[3:0],LR);
Ring_Shift_LR T2(Temp_A,B[3:0],LR);




endmodule
