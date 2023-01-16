`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 21:40:04
// Design Name: 
// Module Name: Reg
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


module Reg(
input clk,//寄存器时钟脉冲
input rst_l,//寄存器复位信号
input [31:0]R_in_d,//寄存器写入数据
input R_e,//寄存器写使能信号

output reg [31:0]R_out_d //寄存器输出数据

    );
 //功能：实现具有使能和复位功能的32位寄存器
 //*******************************************loginc Implementation（程序逻辑实现）***********************************************//
       always@(posedge clk,negedge rst_l)
        if(!rst_l)
             R_out_d<=32'h0;
        else    if(R_e)
                   R_out_d<=R_in_d;
                else
                     R_out_d<=R_out_d;
endmodule
