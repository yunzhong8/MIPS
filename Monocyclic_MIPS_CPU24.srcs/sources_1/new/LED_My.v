`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/31 13:21:18
// Design Name: 
// Module Name: LED_My
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


module LED_My(a,led7s);
//模块功能：输入4位2进制数输出对应的数码管显示数
//输入：待显示的4位二进制数
//输出：数字对应的LED显示控制数
      input [3:0] a;
      output [6:0] led7s;
      reg  [7:0] L;
// 请在下面添加代码，完成7段数码显示译码器显示
/* Begin */
always @ (a)
begin
case(a)
4'b0000:L=8'hbf;//0 bf 0 
4'b0001:L=8'hdb;//2 86 1 
4'b0010:L=8'hcf;//3  db 2 
4'b0011:L=8'hf7;//a  cf  3 
4'b0100:L=8'hb9;//c  e6  4 
4'b0101:L=8'hf9;//e   ED 5 
4'b0110:L=8'h74;//h  FD 6 
4'b0111:L=8'h30;//i 87 7 
4'b1000:L=8'h37;//n  FF 8 
4'b1001:L=8'h73;//p  EF 9 
4'b1010:L=8'h31;//r  a  f7 10  a 
4'b1011:L=8'h6d;//s  b  fc  11 b  
4'b1100:L=8'h6e;//y c   b9  12 c
endcase
end
assign led7s=L[6:0];
/* End */
endmodule    
       
