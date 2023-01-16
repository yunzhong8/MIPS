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
    input  wire [31: 0] x       ,   // Դ������x, ��һ����rs��ֵ, ���һ��ȷ�� (�� sll, srl, sra)  
    input  wire [31: 0] y       ,   // Դ������y, ��һ����rt��ֵ, ���һ��ȷ�� (�� I��ָ��)
    input wire  [4:0]shamt,
    input  wire [3 : 0] aluop   ,   // alu op
    output reg  [31: 0] r           // ������ result
    );
    
    always @(*)begin                // ��д��������� (�����Ż����Ӽ��Ƚ϶���ͨ���ӷ������)
        r = 0;
        case(aluop)
            `AluOpSll: r = (y << shamt);                     // sll, sllv
            `AluOpSrl: r = (y >> shamt);                     // srl, srlv
            `AluOpSra: r = ($signed(y) >>> shamt);           // sra, srav    
//             `AluOpSll: r = (y << x[4:0]);                     // sll, sllv
//            `AluOpSrl: r = (y >> x[4:0]);                     // srl, srlv
//            `AluOpSra: r = ($signed(y) >>> x[4:0]);           // sra, srav   
            // (verilog����Ĭ���޷�����, $signed()ǿ��ת��Ϊ�з�����, ">>>"�������������)
            
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


