`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/09 17:45:40
// Design Name: 
// Module Name: dm
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



module dm(
    input  wire         clk     ,
    input  wire         we      ,
    input  wire         re      ,
    input  wire [5 : 0] addr    ,
    input  wire [31: 0] wdata   ,
    output wire [31: 0] rdata
    );

    reg [31:0] data_mem [63:0];

    integer i;
    initial for(i=0;i<64;i=i+1) data_mem[i] = 0;

    always @(posedge clk) begin
        if(we == 1'b1) data_mem[addr] <= wdata;
    end

    assign rdata = (re == 1'b1)? data_mem[addr] : 32'b0;

endmodule

