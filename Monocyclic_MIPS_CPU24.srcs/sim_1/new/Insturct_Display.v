`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/24 11:26:51
// Design Name: 
// Module Name: Insturct_Display
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


module Instruct_Display(
input [32:0]id_in_d


    );
    wire [5:0]Op,Func;
    assign Op=id_in_d[31:26];
    assign Func=id_in_d[5:0];
    always @(id_in_d)
     if(Op==6'h0)
                    case(Func)
                        6'd0:$display($time,," ***********************����ָ��ΪSLL***********************");
                        6'd3:$display($time,," ***********************����ָ��ΪSRA");
                        6'd2:$display($time,," ***********************����ָ��ΪSRL");
                        6'd32:$display($time,," ***********************����ָ��ΪADD");
                        6'd33:$display($time,," ***********************����ָ��ΪADDU");
                        6'd34:$display($time,," ***********************����ָ��ΪSUB");
                        6'd36:$display($time,," ***********************����ָ��ΪAND");
                        6'd37:$display($time,," ***********************����ָ��ΪOR");
                        6'd39:$display($time,," ***********************����ָ��ΪNOR");
                        6'd42:$display($time,," ***********************����ָ��ΪSLT");
                        6'd43:$display($time,," ***********************����ָ��ΪSLTU");
                        6'd8:$display($time,," ***********************����ָ��ΪJR");
                        6'd12:$display($time,," ***********************����ָ��ΪSYSCALL");
                                endcase
                else
                    case(Op)
                        6'd2:$display($time,," ***********************����ָ��ΪJ");
                        6'd3:$display($time,," ***********************����ָ��ΪJAL");
                        6'd4:$display($time,," ***********************����ָ��ΪBNQ");
                        6'd5:$display($time,," ***********************����ָ��ΪBNEL");
                        6'd8:$display($time,," ***********************����ָ��ΪADDI");
                        6'd12:$display($time,," ***********************����ָ��ΪANDI");
                        6'd9:$display($time,," ***********************����ָ��ΪADDU");
                        6'd10:$display($time,," ***********************����ָ��ΪSLTI");
                        6'd13:$display($time,," ***********************����ָ��ΪORI");
                        6'd35:$display($time,," ***********************����ָ��ΪLW");
                        6'd43:$display($time,," ***********************����ָ��ΪSW");
                    endcase
                    
endmodule
