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
    parameter DW = 32   // Data Width, �Ĵ���λ��
)(
    input  wire           clk     ,
    input  wire           rst_n   , // ��λ���͵�ƽ��Ч�����첽����
    input  wire           en      , // ʹ��
    input  wire [DW-1: 0] din     ,
    output reg  [DW-1: 0] dout
    );
    
    always @(posedge clk)begin
        if (!rst_n) dout <= 0;
        else if (en) dout <= din;
        else dout <= dout;
    end    
    
endmodule
