`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/15 22:03:55
// Design Name: 
// Module Name: Priority_Resolver
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


module Priority_Resolver(
input [7:0]pr_in_d,//输入中断信号
output reg [3:0]pr_out_d//输出这些中断信号中最优先的中断有优先级（即地址）
    );
    always@(*)
        if(pr_in_d[7]==1'b1)
            pr_out_d<=3'd7;
            else     if(pr_in_d[6]==1'b1)
                        pr_out_d<=3'd6;
                    else    if(pr_in_d[5]==1'b1)
                                 pr_out_d<=3'd5;
                            else     if(pr_in_d[4]==1'b1)
                                         pr_out_d<=3'd4;
                                     else   if(pr_in_d[3]==1'b1)
                                                pr_out_d<=3'd3;
                                            else    if(pr_in_d[2]==1'b1)
                                                         pr_out_d<=3'd2;
                                                    else    if(pr_in_d[1]==1'b1)
                                                                 pr_out_d<=3'd1;
                                                            else    if(pr_in_d[0]==1'b1)
                                                                        pr_out_d<=3'd0;
                                                                 else
                                                                        pr_out_d<=3'd0;
endmodule
