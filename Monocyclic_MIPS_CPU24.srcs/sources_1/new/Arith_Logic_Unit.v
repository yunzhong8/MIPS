`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 22:22:01
// Design Name: 
// Module Name: Arith_Logic_Unit
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


module Arith_Logic_Unit
(
input rst_l,

input [31:0]alu_in_a,//参加运算的数A
input [31:0]alu_in_b,//参加运算的数B
input [4:0]alu_in_shamt,
input [3:0]alu_in_contr,//运算功能控制

output reg alu_out_equ,
output reg [31:0] alu_out_rl,//低字节
output reg [31:0] alu_out_rh//高字节

);
//缩写ALU
//输入32位的参加运算的A，B，4位运算种类的控制 alu_in_contr
//输出运算结果64位，分为2个32位的输出口

reg LR;
wire [31:0]Temp_A;
always @(alu_in_a,alu_in_b,alu_in_contr,Temp_A,rst_l)
if(!rst_l)
begin
alu_out_equ=1'b0;
alu_out_rh=32'h0;
alu_out_rl=32'h0;
end
else
begin
alu_out_equ<=(alu_in_a==alu_in_b)? 1'b1 :1'b0;
case(alu_in_contr)
4'b0000:alu_out_rl<=alu_in_b<<alu_in_shamt;//0左移
4'b0001:
        begin
        LR=1;
       alu_out_rl<=Temp_A;
end//1循环右移
4'b0010:alu_out_rl<=alu_in_b>>alu_in_shamt;//2右移


4'b0011:{alu_out_rh,alu_out_rl}<=alu_in_a*alu_in_b;//3乘法
4'b0100:{alu_out_rh,alu_out_rl}<=alu_in_a/alu_in_b;//4除法
4'b0101:{alu_out_rh,alu_out_rl}<=alu_in_a+alu_in_b;//5加法
4'b0110:alu_out_rl<=alu_in_a-alu_in_b;//6减法
4'b0111:alu_out_rl<=alu_in_a&alu_in_b;//7and
4'b1000:alu_out_rl<=alu_in_a|alu_in_b;//8OR
4'b1001:alu_out_rl<=alu_in_a^alu_in_b;//9XOR
4'b1010:alu_out_rl<=alu_in_a^~alu_in_b;//aNOR
4'b1011:
       if(alu_in_a>alu_in_b)//c不相等
            alu_out_rl<=32'h0;
        else
            alu_out_rl<=32'h1;
4'b1100:
        if(alu_in_a>alu_in_b)//c不相等
            alu_out_rl<=32'h0;
        else
            alu_out_rl<=32'h1;
4'b1101:;//d
4'b1110:;//e 
4'b1111:;//f
endcase
end
Ring_Shift_LR T1(alu_in_b,alu_in_shamt,LR,Temp_A);
Ring_Shift_LR T2(alu_in_b,alu_in_shamt,LR,Temp_A);


endmodule

//endmodule
//`include "defines.v"
//module alu(
//    input  wire [31: 0] x       ,   // 源操作数x, 不一定是rs的值, 需进一步确定 (如 sll, srl, sra)  
//    input  wire [31: 0] y       ,   // 源操作数y, 不一定是rt的值, 需进一步确定 (如 I型指令)
//    input wire  [4:0]shamt,
//    input  wire [3 : 0] aluop   ,   // alu op
//    output reg  [31: 0] r           // 运算结果 result
//    );
    
//    always @(*)begin                // 本写法最简单明了 (还可优化，加减比较都可通过加法器解决)
//        r = 0;
//        case(aluop)
//            `AluOpSll: r = (y << shamt);                     // sll, sllv
//            `AluOpSrl: r = (y >> shamt);                     // srl, srlv
//            `AluOpSra: r = ($signed(y) >>> shamt);           // sra, srav    
////             `AluOpSll: r = (y << x[4:0]);                     // sll, sllv
////            `AluOpSrl: r = (y >> x[4:0]);                     // srl, srlv
////            `AluOpSra: r = ($signed(y) >>> x[4:0]);           // sra, srav   
//            // (verilog变量默认无符号数, $signed()强制转换为有符号数, ">>>"算术右移运算符)
            
//            `AluOpAdd: r = x + y;                             // add
//            `AluOpSub: r = x - y;                             // sub

//            `AluOpAnd: r =  (x & y);                          // and
//            `AluOpOr : r =  (x | y);                          // or
//            `AluOpXor: r =  (x ^ y);                          // xor
//            `AluOpNor: r = ~(x | y);                          // nor

//            `AluOpSlt : r = ($signed(x) < $signed(y))? 1 : 0; // slt
//            `AluOpSltu: r = (x < y)? 1 : 0;                   // sltu

//            `AluOpLui: r = {y[15:0], 16'h0000};               // lui
//            `AluOpEqu: r = (x ==y)? 1 : 0; 

//            default: r = 0;
//        endcase
//    end
//endmodule

