`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/24 17:23:41
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
input [3:0]btn_pin,
output [7:0]seg_cs_pin,
output [7:0]seg_data_0_pin,
output [7:0]seg_data_1_pin,
output [15:0]led_pin
    );
//*******************************************Define Inner Variable（定义内部变量）***********************************************//
    //分频器 
        wire clk_1ms,clk_10ms, clk_100ms,clk_1s;
    //CPU 
        wire [31:0]LED_DATA;
        wire [15:0]cpu_out_ild;
        wire Go;
    //LED
        wire[31:0]res;
        wire[3:0]sel_1;//控制右边4个4 3 2 1
        wire[3:0]sel_2;//控制左边4个8 7 6 5
        wire[7:0]seg7_1;
        wire[7:0]seg7_2;
    
//*******************************************loginc Implementation（程序逻辑实现）***********************************************//
   //$$$$$$$$$$$$$$$（ 时钟分频 模块）$$$$$$$$$$$$$$$$$$// 
         Clk_Div_Ms_S CDMS(sys_clk_in,sys_rst_n,clk_1ms,clk_10ms,clk_100ms,clk_1s );
    //#################（ 模块结束）#################//  
   
     //$$$$$$$$$$$$$$$（CPU  模块）$$$$$$$$$$$$$$$$$$// 
        assign Go=btn_pin;
        CPU T1(clk_10ms,sys_rst_n,Go,LED_DATA,cpu_out_ild);
        assign led_pin=cpu_out_ild;                      
	//#################（ 模块结束）#################//  
        
    //$$$$$$$$$$$$$$$（ 数码管显示 模块）$$$$$$$$$$$$$$$$$$// 
          assign res=LED_DATA;      
          LED_display LD(clk_1ms,sys_rst_n,res,
                     sel_1,//控制右边4个4 3 2 1
                     sel_2,//控制左边4个8 7 6 5
                     seg7_1,
                     seg7_2);
                     
         assign seg_cs_pin={sel_1,sel_2};//数码管位信号输出
         assign seg_data_0_pin=seg7_1;//1号数码管段信号输出
         assign seg_data_1_pin=seg7_2;//2号数码管段信号输出
	//#################（ 模块结束）#################//                    
  

endmodule
