`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/11 12:43:45
// Design Name: 
// Module Name: controller
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
//因为没标明输入的位宽导致错误

module controller(
input  [5:0]Op,
input [5:0]Func,

output wire Halt,
output wire MemtoReg,
output wire MemWrite,
output wire Beq,
output wire Bne,
output reg AluOP,
output wire AluSrcB,
output wire RegWrite,
output wire RegDst
    );
    
    reg LW,SW,BEQ,BNE,ADDI,R;
    reg ADD,SLT,SysCall;
    wire R_TYPE;
    
    //识别L指令和其他指令指令类型
    always @(*)
    case(Op)
    6'h23: LW<=1'b1;
    6'h2b: SW<=1'b1;
    6'h04: BEQ<=1'b1;
    6'h05: BNE<=1'b1;
    6'h08: ADDI<=1'b1;
    6'h00:R<=1'b1;
    endcase
    
    //识别其他指令中：R型，J型，Syscall
     always @(Func)
     if(R==1'b1)
    case(Func)
    6'h20:ADD<=1'b1;
    6'h2a:SLT<=1'b1;
    8'h0c:SysCall<=1'b1;
    endcase
    
    assign R_TYPR=ADD|SLT;
    
    //AluOP产生
    always@(*)
    case((R)&&(Func==6'h2a))
    1'b0:AluOP<=4'h5;
    1'b1:AluOP<=4'hc;
    endcase
    
    //控制信号产生
    assign RegDst=R_TYPE;
    assign RegWrite=LW|LW|R_TYPE;
    assign MemtoReg=LW;
    assign MemWrite=SW;
    assign AluSrcB=SW|LW|ADDI;
    assign Beq=BEQ;
    assign Bne=BNE;
    assign Halt=SysCall;
    
endmodule
