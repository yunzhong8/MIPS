`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 18:51:15
// Design Name: 
// Module Name: sim_Controller_Uint
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


module sim_Controller_Uint(

    );
    reg[5:0] cu_Op;
    reg [5:0]cu_Func;
    wire cu_Halt, cu_MemtoReg, cu_MemWrite,cu_Beq,cu_Bne, cu_AluSrcB, cu_RegWrite,cu_RegDst;
     wire [3:0]cu_AluOP;
    
    Controller_Uint CU(cu_Op,cu_Func,
    cu_Halt, cu_MemtoReg, cu_MemWrite,cu_Beq,cu_Bne, cu_AluOP, cu_AluSrcB, cu_RegWrite,cu_RegDst);
    initial
    begin
    #5 cu_Op=6'h0;cu_Func=6'h20;//ADD
    #5 cu_Op=6'h0;cu_Func=6'h2a;//STL
    #5 cu_Op=6'h0;cu_Func=6'h0c;//SysCall
    //I÷∏¡Ó
    #5 cu_Op=6'h23;cu_Func=6'h32;//LW
    #5 cu_Op=6'h2b;cu_Func=6'h32;//SW
    #5 cu_Op=6'h4;cu_Func=6'h32;//BEQ 
    #5 cu_Op=6'h5;cu_Func=6'h32;//BNE
     #5 cu_Op=6'h8;cu_Func=6'h32;//ADDI
    end
endmodule
