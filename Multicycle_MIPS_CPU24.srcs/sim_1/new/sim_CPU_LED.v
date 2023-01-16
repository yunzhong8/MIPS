`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 23:31:21
// Design Name: 
// Module Name: sim_CPU_LED
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


module sim_CPU_LED(

    );   
         reg sys_clk_in,sys_rst_n;
         //分频器 
         wire clk_1ms,clk_10ms, clk_100ms,clk_1s,clk_10s;
         //LED
         reg [31:0]res;
         wire[3:0]sel_1;//控制右边4个4 3 2 1
         wire[3:0]sel_2;//控制左边4个8 7 6 5
         wire[7:0]seg7_1;
         wire[7:0]seg7_2;
         //
         wire[7:0]seg_cs_pin,seg_data_0_pin,seg_data_1_pin;

         initial
             begin
                 sys_clk_in=1'b1;
                 sys_rst_n=1'b0;
                 #3sys_rst_n=1'b1;
             end

         always#5
             sys_clk_in=~sys_clk_in;
             
           Clk_Div_Ms_S CDMS(
                                  sys_clk_in,
                                  sys_rst_n,
                                   clk_1ms,
                                  clk_10ms,
                                  clk_100ms,
                                   clk_1s,
                                   clk_10s
                                 );

          wire [31:0]LED_DATA;
             CPU T1(
                 sys_clk_in,
                 clk_1ms,
                 sys_rst_n,
                 LED_DATA
             //output PC
                     );
            always@(posedge sys_clk_in,negedge sys_rst_n)
                 if(!sys_rst_n)
                 ;
                 else         
                         res<=LED_DATA;    

          LED_display LD(
          sys_clk_in,
          sys_rst_n,
          res,
         sel_1,//控制右边4个4 3 2 1
         sel_2,//控制左边4个8 7 6 5
         seg7_1,
         seg7_2);
         
         assign seg_cs_pin={sel_1,sel_2};//数码管位信号输出
         assign seg_data_0_pin=seg7_1;//1号数码管段信号输出
         assign seg_data_1_pin=seg7_2;//2号数码管段信号输出

         endmodule
