`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 10:51:33
// Design Name: 
// Module Name: LED_show
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


module LED_show(a,led7s);
//模块功能：输入4位2进制数输出对应的数码管显示数
//输入：待显示的4位二进制数
//输出：数字对应的LED显示控制数
      input [3:0] a;
      output [6:0] led7s;
      reg  [6:0] L;
// 请在下面添加代码，完成7段数码显示译码器显示
/* Begin */
always @ (a)
begin
case(a)
4'b0000:L=7'b011_1111;//0 bf
4'b0001:L=7'b000_0110;//1 86
4'b0010:L=7'b101_1011;//2  db 
4'b0011:L=7'b100_1111;//3  cf 
4'b0100:L=7'b110_0110;//4  e6 
4'b0101:L=7'b110_1101;//5  ED
4'b0110:L=7'b111_1101;//6 FD
4'b0111:L=7'b000_0111;//7 87
4'b1000:L=7'b111_1111;//8 FF
4'b1001:L=7'b110_1111;//9 EF
4'b1010:L=7'b111_0111;//10 a  
4'b1011:L=7'b111_1100;//11 b  
4'b1100:L=7'b011_1001;//12 c  
4'b1101:L=7'b101_1110;//13 d  
4'b1110:L=7'b111_1001;//14 e  
4'b1111:L=7'b111_0001;//15f 
endcase
end
assign led7s=L;
/* End */
endmodule    
       
