`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 22:45:34
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
output [7:0]seg_data_1_pin,
output [31:0]cl_out_d
    );
 //*******************************************Define Inner Variable�������ڲ�������***********************************************//   
    //��Ƶ�� ģ���������
        wire clk_1ms,clk_10ms, clk_100ms,clk_1s,clk_10s;
    //CPU ģ���������
        wire [31:0]cpu_out_d;
    //LED ģ���������
        wire[31:0]ld_in_d;
        wire[3:0]sel_1;//�����ұ�4��4 3 2 1
        wire[3:0]sel_2;//�������4��8 7 6 5
        wire[7:0]seg7_1;
        wire[7:0]seg7_2;

//*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//

    //$$$$$$$$$$$$$$$����Ƶ��  ģ����ã�$$$$$$$$$$$$$$$$$$//             
        Clk_Div_Ms_S CDMS(sys_clk_in,sys_rst_n,clk_1ms,clk_10ms,clk_100ms,clk_1s ,clk_10s);
    //#################����Ƶ�� ģ�������#################//             
    
    //$$$$$$$$$$$$$$$��CPU  ģ����ã�$$$$$$$$$$$$$$$$$$//             
        CPU T1(sys_clk_in,sys_clk_in,sys_rst_n,cpu_out_d);
//      always@(*)
//          $display($time,,"LED_DATA=%h",cpu_out_d);
        assign cl_out_d=cpu_out_d;
        //�����ʾ 
            //       always@(*)
//          $display($time,,"ld_in_d=%h,cpu_out_d=%h",ld_in_d,cpu_out_d); 
    //#################��CPU ģ�������#################//
    
    
    //$$$$$$$$$$$$$$$��LED��ʾ  ģ����ã�$$$$$$$$$$$$$$$$$$//                                           
         assign ld_in_d=1'b0 ? 32'h5:cpu_out_d;   

         LED_display LD(sys_clk_in,sys_rst_n,ld_in_d,
                         sel_1,//�����ұ�4��4 3 2 1
                         sel_2,//�������4��8 7 6 5
                         seg7_1,
                         seg7_2);
                         
        assign seg_cs_pin={sel_1,sel_2};//�����λ�ź����
        assign seg_data_0_pin=seg7_1;//1������ܶ��ź����
        assign seg_data_1_pin=seg7_2;//2������ܶ��ź����
    //#################��LED��ʾ ģ�������#################//

endmodule

