`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/07 23:20:09
// Design Name: 
// Module Name: JK_Trigger
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


module JK_Trigger(
input wire Clk,
input wire rst_l,
input wire J,
input wire K,
output reg Q,
output reg Q_l
    );
 
// 公式
    always @(posedge Clk) 
        if(!rst_l)
            begin
                Q<=1'b0;
                Q_l<=~Q;
            end
        else
            begin
                case({J,K})
                    2'b00:Q<=Q;
                    2'b01:Q<=0;
                    2'b10:Q<=1;
                    2'b11:Q<=~Q;
                endcase
                  Q_l<=~Q;
                
             end
// 查找表
//    always @(posedge Clk)
//        case({J,K})
//           2'b00: Q <= Q;
//           2'b01: Q <= 0;
//           2'b10: Q <= 1;
//           2'b11: Q <= ~Q;
//       endcase
 
endmodule

