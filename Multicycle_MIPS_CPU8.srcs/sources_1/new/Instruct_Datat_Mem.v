`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 20:47:28
// Design Name: 
// Module Name: Instruct_Datat_Mem
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


module Instruct_Datat_Mem(
input clk,//在整个存储器的时钟脉冲
input rst_l,//复位信号
input [9:0]idm_in_rwa,//指令数据存储器的读写地址
input [31:0]idm_in_wd,//指令数据存储器的写入数据
input idm_in_we,//指令数据存储器的写入使能信号 
input idm_in_re,//指令数据存储器的读出使能信号

output reg[31:0]idm_out_rd//指令数据存储器的读出数
    );
//功能：在时钟上升沿根据写使能和读使能，读出地址对应的数据,和写入地址对应的空间
 //*******************************************Define Inner Variable（定义内部变量）***********************************************//
	 parameter IDM_LEN=138;
    reg[31:0]ID_Mem[IDM_LEN:0];
    reg [5:0]i=6'h0;

 //*******************************************loginc Implementation（程序逻辑实现）***********************************************//
     //$$$$$$$$$$$$$$$（写数据 模块调用）$$$$$$$$$$$$$$$$$$// 
        always@(posedge clk,negedge rst_l)//写数据
            if(!rst_l)
           ;
            else    if(idm_in_we)//根据读写使能信号：读写数据
                        ID_Mem[idm_in_rwa]<=idm_in_wd;
  
	//#################（ 模块结束）#################// 
	
	
	
	//$$$$$$$$$$$$$$$（读数据 模块）$$$$$$$$$$$$$$$$$$// 
	    always@(*)
            if(!rst_l)
                begin
                    $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt",ID_Mem);
//                  $display("初始化指令存储");
//                  repeat(39)
//                    begin
//                        $display("ID_Mem[%h]=%h",i,ID_Mem[i]);
//                        i=i+6'h1;
//                     end
                end
           else  if(idm_in_re)
                        begin
                            idm_out_rd<=ID_Mem[idm_in_rwa];
//                          $display($time,,"输出数据存储对应位置的值");
//                          $display("DM[80]=%h,DM[81]=%h,DM[82]=%h,DM[83]=%h,DM[84]=%h,DM[85]=%h,DM[86]=%h,DM_Mem[87]=%h"
//                                    ,ID_Mem[8'h80],ID_Mem[8'h81],ID_Mem[8'h82],ID_Mem[8'h83],ID_Mem[8'h84],ID_Mem[8'h85],ID_Mem[8'h86],ID_Mem[8'h87]);
                         end
                  else
                        idm_out_rd<=idm_out_rd;
	//#################（ 模块结束）#################//
endmodule
