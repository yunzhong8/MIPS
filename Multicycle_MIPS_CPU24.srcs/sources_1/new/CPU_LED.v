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
 //*******************************************Define Inner Variable（定义内部变量）***********************************************//   
    //分频器 模块变量定义
        wire clk_1ms,clk_10ms, clk_100ms,clk_1s,clk_10s;
    //CPU 模块变量定义
        wire [31:0]cpu_out_d;
    //LED 模块变量定义
        wire[31:0]ld_in_d;
        wire[3:0]sel_1;//控制右边4个4 3 2 1
        wire[3:0]sel_2;//控制左边4个8 7 6 5
        wire[7:0]seg7_1;
        wire[7:0]seg7_2;

//*******************************************loginc Implementation（程序逻辑实现）***********************************************//

    //$$$$$$$$$$$$$$$（分频器  模块调用）$$$$$$$$$$$$$$$$$$//             
        Clk_Div_Ms_S CDMS(sys_clk_in,sys_rst_n,clk_1ms,clk_10ms,clk_100ms,clk_1s ,clk_10s);
    //#################（分频器 模块结束）#################//             
    
    //$$$$$$$$$$$$$$$（CPU  模块调用）$$$$$$$$$$$$$$$$$$//             
        CPU T1(sys_clk_in,sys_clk_in,sys_rst_n,cpu_out_d);
//      always@(*)
//          $display($time,,"LED_DATA=%h",cpu_out_d);
        assign cl_out_d=cpu_out_d;
        //输出显示 
            //       always@(*)
//          $display($time,,"ld_in_d=%h,cpu_out_d=%h",ld_in_d,cpu_out_d); 
    //#################（CPU 模块结束）#################//
    
    
    //$$$$$$$$$$$$$$$（LED显示  模块调用）$$$$$$$$$$$$$$$$$$//                                           
         assign ld_in_d=1'b0 ? 32'h5:cpu_out_d;   

         LED_display LD(sys_clk_in,sys_rst_n,ld_in_d,
                         sel_1,//控制右边4个4 3 2 1
                         sel_2,//控制左边4个8 7 6 5
                         seg7_1,
                         seg7_2);
                         
        assign seg_cs_pin={sel_1,sel_2};//数码管位信号输出
        assign seg_data_0_pin=seg7_1;//1号数码管段信号输出
        assign seg_data_1_pin=seg7_2;//2号数码管段信号输出
    //#################（LED显示 模块结束）#################//

endmodule

