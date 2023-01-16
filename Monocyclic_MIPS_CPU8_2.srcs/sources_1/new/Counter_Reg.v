`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 11:13:40
// Design Name: 
// Module Name: Counter_Reg
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


module Counter_Reg(
input clk,
input rst_l,
input cr_in_ae,
input cr_in_se,
input cr_in_stop,
output reg[CRD_LEN:0]cr_out_d

    );
//*******************************************Define Inner Variable***********************************************//
    parameter CRD_LEN=5'd31;
 //*******************************************loginc Implementation***********************************************//
    //¼Ó
    always@(posedge clk,negedge rst_l)
        if(!rst_l)
            cr_out_d<=32'h0;
        else
           case({cr_in_stop,cr_in_ae,cr_in_se})
               3'b000: cr_out_d<=cr_out_d;
               3'b001:cr_out_d<=cr_out_d-32'h1;
               3'b010:cr_out_d<=cr_out_d+32'h1;
               default:cr_out_d<=cr_out_d;
           endcase
endmodule
