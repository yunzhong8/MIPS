`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 20:00:28
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
    //��ϵ�·����д����ģ������ SE
    //�����������λ������ӿ�����se_in
    //�����Ӧ���λ��32λ��չ,����ӿ�����se_out
    //�������
    
    always@(*)
    if(se_in_sign==1'b1)
    se_out_data<=32'hffff_ffff;
    else
    se_out_data<=32'h0000_0000;
endmodule
