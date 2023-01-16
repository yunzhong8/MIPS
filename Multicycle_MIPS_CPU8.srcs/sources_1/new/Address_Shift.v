`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 19:45:07
// Design Name: 
// Module Name: Address_Shift
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


module Address_Shift(
input [6:0]ad_in_instr,
output reg [3:0]ad_out_address

    );
    always@(*)
    case(ad_in_instr)
   7'b000_0001:ad_out_address <=4'd13;//d
   7'b000_0010:ad_out_address <=4'd10;//a
   7'b000_0100:ad_out_address <=4'd9;
   7'b000_1000:ad_out_address <=4'd5;
   7'b001_0000:ad_out_address <=4'd2;
   7'b010_0000:ad_out_address <=4'd11;//c
   7'b100_0000:ad_out_address <=4'd7;
   endcase
//   always@(*)
//     $display($time,,"地址转移器内的输入输出：ad_in_instr=%h,ad_out_address=%h",ad_in_instr,ad_out_address);
endmodule
