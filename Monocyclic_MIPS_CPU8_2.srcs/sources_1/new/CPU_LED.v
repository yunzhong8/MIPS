`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 13:18:29
// Design Name: 
// Module Name: CPU_LED
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


module CPU_LED(
input sys_clk_in,
input sys_rst_n,
output [7:0]seg_cs_pin,
output [7:0]seg_data_0_pin,
output [7:0]seg_data_1_pin
    );
//��Ƶ�� 
    wire clk_1ms,clk_10ms, clk_100ms,clk_1s,clk_10s;
//CPU 
    wire [31:0]LED_DATA;
//LED
    wire[31:0]res;
    wire[3:0]sel_1;//�����ұ�4��4 3 2 1
    wire[3:0]sel_2;//�������4��8 7 6 5
    wire[7:0]seg7_1;
    wire[7:0]seg7_2;
    

    Clk_Div_Ms_S CDMS(sys_clk_in,sys_rst_n,clk_1ms,clk_10ms,clk_100ms,clk_1s ,clk_10s);

    CPU T1(sys_clk_in,clk_1s,sys_rst_n,LED_DATA);
                                              
    assign res=LED_DATA;   
    
    LED_display LD(clk_1ms,sys_rst_n,res,
                     sel_1,//�����ұ�4��4 3 2 1
                     sel_2,//�������4��8 7 6 5
                     seg7_1,
                     seg7_2);
                 
    assign seg_cs_pin={sel_1,sel_2};//�����λ�ź����
    assign seg_data_0_pin=seg7_1;//1������ܶ��ź����
    assign seg_data_1_pin=seg7_2;//2������ܶ��ź����

endmodule