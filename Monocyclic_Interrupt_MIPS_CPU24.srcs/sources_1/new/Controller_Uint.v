`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 22:23:02
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
input rst_l,
input [5:0]Op,
input [5:0]Func,

output wire[3:0] AluOP,
output wire MemToReg,
output wire MemWrite,
output wire Alu_SrcB,
output wire RegWrite,
output wire SysCall,

output wire SignedExt,
output wire RegDst,
output wire Beq,
output wire Bne,
output wire JR,
output wire JMP,
output wire JAL,
output wire ERER
    );
  
reg [4:0]CU_address;
reg[12:0]CU_I_Mem[24:0] ;
reg[4:0]CU_Alu_Mem[24:0] ;
reg[4:0]i=5'h1;


always @(*)
    if(!rst_l)
        begin
            $readmemb("D:/Documents/Hardware_verlog/Source_Data/Monocyclic_MIPS_CPU24/CU_Data.txt",CU_I_Mem,1);
            $readmemh("D:/Documents/Hardware_verlog/Source_Data/Monocyclic_MIPS_CPU24/CU_ALU_Data.txt",CU_Alu_Mem,1);
//            repeat(24)
//                    begin
//                     $display($time,,"CU_I_Mem[%d]=%h,CU_Alu_Mem[%d]=%h",i,CU_I_Mem[i],i,CU_Alu_Mem[i]);
//                     i=i+5'h1;
//                     end 
      end
        
    else    if(Op==6'h0)
                    case(Func)
                        6'd0:CU_address<=5'd1;
                        6'd3:CU_address<=5'd2;
                        6'd2:CU_address<=5'd3;
                        6'd32:CU_address<=5'd4;
                        6'd33:CU_address<=5'd5;
                        6'd34:CU_address<=5'd6;
                        6'd36:CU_address<=5'd7;
                        6'd37:CU_address<=5'd8; 
                        6'd39:CU_address<=5'd9;
                        6'd42:CU_address<=5'd10;
                        6'd43:CU_address<=5'd11;
                        6'd8:CU_address<=5'd12;
                        6'd12:CU_address<=5'd13;
                      endcase
                else
                    case(Op)
                        6'd2:CU_address<=5'd14;
                        6'd3:CU_address<=5'd15;
                        6'd4:CU_address<=5'd16;
                        6'd5:CU_address<=5'd17;
                        6'd8:CU_address<=5'd18;
                        6'd12:CU_address<=5'd19;
                        6'd9:CU_address<=5'd20;
                        6'd10:CU_address<=5'd21; 
                        6'd13:CU_address<=5'd22;
                        6'd35:CU_address<=5'd23;
                        6'd43:CU_address<=5'd24;
                        6'd16:CU_address<=5'd25;//ERET地址
                    endcase
//    always@(*)
//         begin
//               $display($time,,"控制器内的：OP=%h,Func=%h",Op,Func);
//               $display($time,,"控制器内部地址Address=%d",CU_address);
//         end
    assign AluOP=CU_Alu_Mem[CU_address];
    assign {ERER,MemToReg,MemWrite,Alu_SrcB,RegWrite,SysCall,SignedExt,RegDst,Beq,Bne,JR,JMP,JAL}=CU_I_Mem[CU_address];//txt文件要修改
   endmodule
           
           
           
           
           
           
