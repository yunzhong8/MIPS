`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/09 15:05:44
// Design Name: 
// Module Name: alu
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


`include "defines.v"
module alu(
    input  wire [31: 0] x       ,   // 源操作数x, 不一定是rs的值, 需进一步确定 (如 sll, srl, sra)  
    input  wire [31: 0] y       ,   // 源操作数y, 不一定是rt的值, 需进一步确定 (如 I型指令)
    input wire  [4:0]shamt,
    input  wire [3 : 0] aluop   ,   // alu op
    output reg  [31: 0] r           // 运算结果 result
    );
    
    always @(*)begin                // 本写法最简单明了 (还可优化，加减比较都可通过加法器解决)
        r = 0;
        case(aluop)
            `AluOpSll: r = (y << shamt);                     // sll, sllv
            `AluOpSrl: r = (y >> shamt);                     // srl, srlv
            `AluOpSra: r = ($signed(y) >>> shamt);           // sra, srav    
//             `AluOpSll: r = (y << x[4:0]);                     // sll, sllv
//            `AluOpSrl: r = (y >> x[4:0]);                     // srl, srlv
//            `AluOpSra: r = ($signed(y) >>> x[4:0]);           // sra, srav   
            // (verilog变量默认无符号数, $signed()强制转换为有符号数, ">>>"算术右移运算符)
            
            `AluOpAdd: r = x + y;                             // add
            `AluOpSub: r = x - y;                             // sub

            `AluOpAnd: r =  (x & y);                          // and
            `AluOpOr : r =  (x | y);                          // or
            `AluOpXor: r =  (x ^ y);                          // xor
            `AluOpNor: r = ~(x | y);                          // nor

            `AluOpSlt : r = ($signed(x) < $signed(y))? 1 : 0; // slt
            `AluOpSltu: r = (x < y)? 1 : 0;                   // sltu

            `AluOpLui: r = {y[15:0], 16'h0000};               // lui
            `AluOpEqu: r = (x ==y)? 1 : 0; 

            default: r = 0;
        endcase
    end
endmodule


