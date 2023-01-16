`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/29 10:50:42
// Design Name: 
// Module Name: LED_display
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


module LED_display(
input clk_1ms,
input rst_l,
input [31:0]res,
output reg[3:0]sel_1,//控制右边4个4 3 2 1
output reg[3:0]sel_2,//控制左边4个8 7 6 5
output reg[7:0]seg7_1,
output reg[7:0]seg7_2);

wire [6:0]seg_data1,seg_data2;

//reg类型变量初始化 
reg[3:0] led_data1,led_data2;
reg [2:0] led_cnt;
parameter LED_CNT_MAX=4 ;
//logic implementation

//循环计数（时序电路）
always @(posedge clk_1ms,negedge rst_l)
if(!rst_l)//当复位信号有效的时候赋值控制端口的值
led_cnt<=3'd0;
else if(led_cnt==LED_CNT_MAX)
led_cnt<=3'd1;
else
led_cnt<=led_cnt+1'b1;

//位信号产生（多路选择器）
always @(led_cnt)
case(led_cnt)
3'd1:
begin
sel_1<=4'b0001;
sel_2<=4'b0001;
end
3'd2:
begin
sel_1<=4'b0010;
sel_2<=4'b0010;
end
3'd3:
begin
sel_1<=4'b0100;
sel_2<=4'b0100;
end
3'd4:
begin
sel_1<=4'b1000;
sel_2<=4'b1000;
end
default:begin
sel_1<=4'b0000;
sel_2<=4'b0000;
end
endcase
//位信号产生(多路选择器)
always @(sel_1)
  case(sel_1)
        4'b0001:led_data1<=res[3:0];
        4'b0010:led_data1<=res[7:4];
        4'b0100:led_data1<=res[11:8];
        4'b1000:led_data1<=res[15:12];
        default: led_data1<=4'b0000;
  endcase
 //位信号产生(多路选择器)
 always @(sel_2)
     case(sel_2)
    4'b0001:led_data2<=res[19:16];
    4'b0010:led_data2<=res[23:20];
    4'b0100:led_data2<=res[27:24];
    4'b1000:led_data2<=res[31:28];
    default:led_data2<=4'b0000;
endcase

//组合电路
LED_show T2(led_data2,seg_data2);
LED_show T1(led_data1,seg_data1);

//seg1段信号产生(组合电路 )
always @(seg_data1)
    if(!rst_l)//对数码管复位
            seg7_1<=8'hff;
    else
        seg7_1<={1'b1,seg_data1};//小数点有效
        
//seg2段信号产生(组合电路 )
always @(seg_data2)
if(!rst_l)//对数码管复位
        seg7_2<=8'hff;
    else
       seg7_2<={1'b1,seg_data2};//小数点有效

endmodule
