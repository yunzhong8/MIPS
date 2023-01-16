`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/09 17:40:29
// Design Name: 
// Module Name: dff
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



module dff #(
    parameter DW = 32   // Data Width, 寄存器位宽
)(
    input  wire           clk     ,
    input  wire           rst_n   , // 复位，低电平有效，非异步触发
    input  wire           en      , // 使能
    input  wire [DW-1: 0] din     ,
    output reg  [DW-1: 0] dout
    );
    
    always @(posedge clk)begin
        if (!rst_n) dout <= 0;
        else if (en) dout <= din;
        else dout <= dout;
    end    
    
endmodule
