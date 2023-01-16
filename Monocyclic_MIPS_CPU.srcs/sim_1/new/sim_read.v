`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 15:05:01
// Design Name: 
// Module Name: sim_read
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


module sim_read(
    );
    reg[31:0]D_M[40:0];
    integer i;
    initial
    begin
     $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/data.txt",D_M);//±£¥Ê÷∏¡Ó 
     #100 
     for(i=0;i<8'h20;i=i+1)
     $display($time,,"%h",D_M[i]);
   end
endmodule
