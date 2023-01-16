`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/31 14:45:50
// Design Name: 
// Module Name: H_C_Y
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


module H_C_Y(
input sys_clk_in,
input sys_rst_n,
output [7:0]seg_cs_pin,
output [7:0]seg_data_0_pin,
output [7:0]seg_data_1_pin


    );
    
    wire clk;
    wire clk_led;
    
    reg[31:0]LD_Mem[4:0];
    wire[31:0]Led_Data;
    reg [2:0]adr;
    wire [31:0]res;
    //LED
wire[31:0]res;
wire[3:0]sel_1;//控制右边4个4 3 2 1
wire[3:0]sel_2;//控制左边4个8 7 6 5
wire[7:0]seg7_1;
wire[7:0]seg7_2;
    
    wire clk_1ms,clk_10ms, clk_100ms,clk_1s,clk_10s;
    Clk_Div_Ms_S CDMS(sys_clk_in,sys_rst_n,clk_1ms,clk_10ms,clk_100ms,clk_1s,clk_10s );
    
    
    
    always@(posedge clk_100ms,negedge sys_rst_n)
        if(!sys_rst_n)
                begin
                   $readmemh("D:/Documents/Hardware_verlog/H_C_Y.txt",LD_Mem);
//                   $display($time,,"LD_Mem[0]=%h,LD_Mem[1]=%h",LD_Mem[0],LD_Mem[1]);
                end
    
    always@(posedge clk_10s,negedge sys_rst_n)
        if(!sys_rst_n)
                 adr<=3'h0;
            else
                begin 
                    adr<=adr+3'h1;
//                    $display($time,,"地址发生变换");
                end
                
    assign Led_Data=LD_Mem[adr];
                    
                 
  
    
  assign res=Led_Data;
//   always@(sys_clk_in)
//    $display($time,,"res=%h",res);
   LED_My_Display LD(clk_1ms,sys_rst_n,res,
                 sel_1,//控制右边4个4 3 2 1
                 sel_2,//控制左边4个8 7 6 5
                 seg7_1,
                 seg7_2);
                 
   assign seg_cs_pin={sel_1,sel_2};//数码管位信号输出
   assign seg_data_0_pin=seg7_1;//1号数码管段信号输出
   assign seg_data_1_pin=seg7_2;//2号数码管段信号输出
    
    
endmodule
