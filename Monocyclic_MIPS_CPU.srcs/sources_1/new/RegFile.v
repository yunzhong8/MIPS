`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 10:41:42
// Design Name: 
// Module Name: RegFile
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


module RegFile(
input clk,
input rst_l,
input [4:0]R1_A,//读出数据的地址
input [4:0]R2_A,//

input write_enable,//写使能信号
input [4:0]W_A,// 写入数据的地址
input [31:0]W_D,//写入数据

output reg[31:0]R1,//读出寄存器组的数据
output reg[31:0]R2
    );
    
    reg[31:0] RF[4:0];//寄存器主体
    always @(posedge clk ,negedge rst_l)
    if(!rst_l)//复位
    ;
    else    if(write_enable)//当是写入数据时
    RF[W_A]<=W_D;
    else//当是读取数据时
    begin
    R1<=RF[R1_A];//读取R1
    R2=RF[R2_A];//读取R2
    end
endmodule
