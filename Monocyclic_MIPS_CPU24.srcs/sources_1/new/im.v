`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/09 17:49:33
// Design Name: 
// Module Name: im
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


module im(
    input  [9:0] addr,
    output [31: 0] dout
    );
    parameter im_len=244;
    reg [31:0] inst_mem [im_len:0];

    integer i;
    initial for(i=0;i<im_len;i=i+1) inst_mem[i] = 0;

    initial  $readmemh("D:/Documents/Hardware_verlog/Source_Data/Monocyclic_Interrupt_MIPS_CPU24/IR_Data.txt", inst_mem);

    assign dout = inst_mem[addr];

endmodule

