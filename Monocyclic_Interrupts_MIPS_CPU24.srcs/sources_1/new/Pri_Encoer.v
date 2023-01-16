`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/07 23:45:59
// Design Name: 
// Module Name: Pri_Encoer
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


module Pri_Encoer(
input pe_in_d,
output pe_out_d
    );
    
    always@(*)
        case(pe_in_d)
            4'b0001:pe_out_d<=2'h0;
            4'b0010:pe_out_d<=2'h1;
            4'b0100:pe_out_d<=2'h2;
            4'b1000:pe_out_d<=2'h3;
            default pe_out_d=2'hx;
        endcase
endmodule
