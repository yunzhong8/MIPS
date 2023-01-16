`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 21:21:42
// Design Name: 
// Module Name: sim_ Arith_Logic_Unit
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


module sim_Arith_Logic_Unit(
    );
    reg [31:0]alu_in_a,alu_in_b;
    reg [3:0]alu_in_contr;
    reg rst_l;
    wire alu_out_equ;
    wire[31:0] alu_out_rl,alu_out_rh;
    
    
    
    initial
    begin
    rst_l=1'b0;
    #1  rst_l=1'b1;
    $display("%b",4'b0001|4'b0010);
    #5 alu_in_a=32'hffff_ffff;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd0;
    
    #1alu_in_a=32'hffff_ffff;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd1;
    
    #1 alu_in_a=32'hffff_ffff;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd2;
    
    #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd3;
     
    #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0003;
    #1 alu_in_contr=4'd4;
    
    #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd5;
    
     #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd6;
    
     #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd7;
    
      #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd8;
    
      #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd9;
    
      #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd10;
  
    #1alu_in_a=32'h0000_0004;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd11;
    
     #1alu_in_a=32'h0000_0003;
    alu_in_b=32'h0000_0004;
    #1 alu_in_contr=4'd12;
    end
    Arith_Logic_Unit ALU
(rst_l,
alu_in_a,//参加运算的数A
 alu_in_b,//参加运算的数B
 alu_in_contr,//运算功能控制

 alu_out_equ,
 alu_out_rl,//低字节
 alu_out_rh//高字节

);


endmodule
