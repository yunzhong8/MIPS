`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 18:51:37
// Design Name: 
// Module Name: Reg_File
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


module Reg_File(
input clk,
input rst_l,
input [4:0] rf_in_ra1,//读出数据的地址
input [4:0] rf_in_ra2,//

input rf_in_wre,//写使能信号

input [4:0]rf_in_wa,// 写入数据的地址
input [31:0]rf_in_wd,//写入数据

output reg[31:0]rf_out_rd1,//读出寄存器组的数据
output reg[31:0]rf_out_rd2
    );
    
    reg[31:0] RF_Mem[31:0];//寄存器主体
    reg [4:0] i=0;
   
    always @(posedge clk ,negedge rst_l)//写入寄存器组
    begin
         if(!rst_l)//clk
         ;
        else    
             begin
                if(rf_in_wre==1'b1)//当是写入数据时
                     begin
                        RF_Mem[rf_in_wa]=rf_in_wd;//此处写入用<=是错误的，会晚一个时钟脉冲，用了=才是对的为什么，时许电路不应该用<=
//                        $display($time,"输出 写数据时：写读使能信号：rf_in_wre=%h,写数据：rf_in_wd=%h,寄存器组对应单元被写后单元的值：RF_Mem[%h]=%h",rf_in_wre,rf_in_wd,rf_in_wa, RF_Mem[rf_in_wa]);
                      end                         
             end
      end
      
      
      always @(*)//读入寄存器组
           if(!rst_l)//复位
                begin
                    $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/RF_data.txt",RF_Mem);//保存指令 
                    rf_out_rd1<=32'h0000_0000;
                    rf_out_rd2<=32'h0000_0000;
                    //删除
//                     $display($time,,"初始化后寄存组的值");
//                     repeat(32)
//                         begin
//                                $display($time,,"RF_Mem[%h]=%h",i,RF_Mem[i]);
//                                 i=i+5'h1;
//                        end
                     //删除
                end
            else
                begin//读数据
                       rf_out_rd1 <=RF_Mem[rf_in_ra1];//读取R1用<=也是错的,得用=
                       rf_out_rd2 <= RF_Mem[rf_in_ra2];//读取R2
//                       $display($time,"输出 读数据1时：读输出的数据：rf_out_rd1=%h,对应被读单元内保存的值：RF_Mem[%h]=%h",rf_out_rd1,rf_in_ra1,RF_Mem[rf_in_ra1]);
//                       $display($time,"输出 读数据2时：读输出的数据：rf_out_rd2=%h,对应被读单元内保存的值：RF_Mem[%h]=%h",rf_out_rd2,rf_in_ra2,RF_Mem[rf_in_ra2]);
//                       i=5'h0;
//                       $display($time,,"寄存器组中的值");
//                       repeat(32)
//                            begin
//                                $monitor($time,,"RF_Mem[%h]=%h",i,RF_Mem[i]);
//                                i=i+5'h1;
//                            end 
                  end    
                         
endmodule
