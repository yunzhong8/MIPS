`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 18:49:50
// Design Name: 
// Module Name: Controller_Uint
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


module Controller_Uint(
input  [5:0]cu_Op,
input [5:0]cu_Func,

output wire cu_Halt,
output wire cu_MemtoReg,
output wire cu_MemWrite,
output wire cu_Beq,
output wire cu_Bne,
output reg[3:0] cu_AluOP,
output wire cu_AluSrcB,
output wire cu_RegWrite,
output wire cu_RegDst
    );
    
    reg LW=1'b0,SW=1'b0,BEQ=1'b0,BNE=1'b0,ADDI=1'b0,R=1'b0;
    reg ADD=1'b0,SLT=1'b0,SysCall=1'b0;
    wire R_TYPE;
   
    //识别L指令和其他指令指令类型
    always @(*)
    case(cu_Op)
    6'h23:
        begin 
         {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b1_0000_0000;
        end
    6'h2b: 
             begin 
                    {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_1000_0000;
              end
    6'h04:
             begin 
                     {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_0100_0000;
              end
    6'h05: 
            begin 
                     {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_0010_0000;
              end
    6'h08: 
             begin 
                   {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_0001_0000;
             end
            
    6'h00: 
        case(cu_Func)//识别其他指令中：R型，J型，Syscall
            6'h20:
                     begin 
                             {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_0000_1100;
                      end
            6'h2a:
                    begin 
                          {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_0000_1010;
                      end
            8'h0c:
                    begin 
                            {LW,SW,BEQ,BNE,ADDI,R,ADD,SLT,SysCall}=9'b0_0000_0001;
                      end 
         endcase
    
    endcase
 
    
  
    
    //AluOP产生
    always@(*)
    case((R)&(cu_Func==6'h2a))
    1'b0:cu_AluOP<=4'h5;
    1'b1:cu_AluOP<=4'hc;
    endcase
    
    //控制信号产生
    assign cu_RegDst=ADD|SLT;
    assign cu_RegWrite=LW|ADDI|(ADD|SLT);
    assign cu_MemtoReg=LW;
    assign cu_MemWrite=SW;
    assign cu_AluSrcB=SW|LW|ADDI;
    assign cu_Beq=BEQ;
    assign cu_Bne=BNE;
    assign cu_Halt=SysCall;
    
endmodule
