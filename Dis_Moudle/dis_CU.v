module dis_CU(
input clk,
input rst_l,
input  [5:0]Op,
input  [5:0]Func,

input wire Halt,
input wire MemtoReg,
input wire MemWrite,
input wire Beq,
input wire Bne,
input wire[3:0] AluOP,
input wire AluSrcB,
input wire RegWrite,
input wire RegDst
);
    always @(*)
        if(!rst_l);
        else
            $display($time,," Op=%h, Func=%h,Halt=%h, MemtoReg=%h,MemWrite=%h,Beq=%h,Bne=%h,AluOP=%h,AluSrcB=%h,RegWrite=%h,RegDst=%h",
            Op, Func,Halt, MemtoReg,MemWrite,Beq,Bne,AluOP,AluSrcB,RegWrite,RegDst);//≤‚ ‘À˘”√
endmodule