`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 22:21:11
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
input clk,
input rst_l,

input dm_in_wre, //在前面用1有效，后的0有效
input wire [9:0] dm_in_rwa,
input wire [31:0] dm_in_wd,


output reg[31:0] dm_out_rd
);
//单周期的数据存储器 
parameter DM_len=150;
reg [31:0]DM_Mem[ DM_len:0];//定义存储器主体

always @(posedge clk,negedge rst_l )//写入数据存储
    begin
        if(!rst_l)//复位信号有效时
        ; 
        else   
            begin 
                if(dm_in_wre)//复位信号无效时，发出写指令
                    DM_Mem[dm_in_rwa]<= dm_in_wd;
             end
    end
    
    always@(*)//读出数据
            begin
                 if(!rst_l)//复位信号有效时
                        dm_out_rd=32'h0000_0000; 
                 else//发出写指令
                         dm_out_rd <= DM_Mem[dm_in_rwa];
//                 $display("输出：数据存储器 在读写后 存储单元的值DM[80]=%h,DM[81]=%h,DM[82]=%h,DM[83]=%h,DM[84]=%h,DM[85]=%h,DM[86]=%h,DM_Mem[87]=%h"
//                 ,DM_Mem[8'h80],DM_Mem[8'h81],DM_Mem[8'h82],DM_Mem[8'h83],DM_Mem[8'h84],DM_Mem[8'h85],DM_Mem[8'h86],DM_Mem[8'h87]);
             end
endmodule

