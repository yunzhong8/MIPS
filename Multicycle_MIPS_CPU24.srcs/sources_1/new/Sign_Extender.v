`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 22:57:48
// Design Name: 
// Module Name: Sign_Extender
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


module Sign_Extender(
 input  se_in_sign,
 output reg [31:0] se_out_data
    );
    //组合电路，简写调用模块名： SE
    //功能输入最高位，输入接口名：se_in
    //输出对应最高位的32位扩展,输出接口名：se_out
    //符合设计
 //*******************************************loginc Implementation（程序逻辑实现）***********************************************//
    always@(*)
        if(se_in_sign==1'b1)
            se_out_data<=32'hffff_ffff;
        else
            se_out_data<=32'h0000_0000;
endmodule

