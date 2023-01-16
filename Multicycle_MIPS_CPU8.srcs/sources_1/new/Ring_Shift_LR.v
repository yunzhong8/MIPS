`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 18:49:34
// Design Name: 
// Module Name: Ring_Shift_LR
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


module Ring_Shift_LR(
input [31:0]I, 
input [3:0]n,
input r_or_l,
output reg[31:0]R
    );
    parameter MAX=31;
    parameter MIN=0;
    always @(I,n,r_or_l)
    if(r_or_l)
    case(n)
    4'h0:R<=I;
    4'h1:R<={I[0],I[31:1]};
    4'h2:R<={I[1:0],I[31:2]};
    4'h3:R<={I[2:0],I[31:3]};
    4'h4:R<={I[3:0],I[31:4]};
    4'h5:R<={I[4:0],I[31:5]};
    4'h6:R<={I[5:0],I[31:6]};
    4'h7:R<={I[6:0],I[31:7]};
    4'h8:R<={I[7:0],I[31:8]};
    4'h9:R<={I[8:0],I[31:9]};
    4'ha:R<={I[9:0],I[31:10]};
    4'hb:R<={I[10:0],I[31:11]};
    4'hc:R<={I[11:0],I[31:12]};
    4'hd:R<={I[12:0],I[31:13]};
    4'he:R<={I[13:0],I[31:14]};
    4'hf:R<={I[14:0],I[31:15]};
        endcase
    else
    case(n)
    4'h0:R<=I;
    4'h1:R<={I[30:0],I[31]};
    4'h2:R<={I[29:0],I[31:30]};
    4'h3:R<={I[28:0],I[31:29]};
    4'h4:R<={I[27:0],I[31:28]};
    4'h5:R<={I[26:0],I[31:27]};
    4'h6:R<={I[25:0],I[31:26]};
    4'h7:R<={I[24:0],I[31:25]};
    4'h8:R<={I[23:0],I[31:24]};
    4'h9:R<={I[22:0],I[31:23]};
    4'ha:R<={I[21:0],I[31:22]};
    4'hb:R<={I[20:0],I[31:21]};
    4'hc:R<={I[19:0],I[31:20]};
    4'hd:R<={I[18:0],I[31:19]};
    4'he:R<={I[17:0],I[31:18]};
    4'hf:R<={I[16:0],I[31:17]};
        endcase
endmodule


