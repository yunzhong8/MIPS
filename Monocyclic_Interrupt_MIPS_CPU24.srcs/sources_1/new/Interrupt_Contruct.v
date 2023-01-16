`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/07 23:00:28
// Design Name: 
// Module Name: Interrupt_Contruct
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


module Interrupt_Contruct(
input clk,
input rst_l,
input [7:0] ic_in_is,//interruct sign
input ERET,
input[31:0]ic_in_ra,//输入地址

output reg INT,
output reg [31:0]ic_out_ia,//输出中断子程序地址
output[31:0]ic_out_ea,//输出中断结束后的指令地址
output reg[3:0]Led_Sign

    );
 //*******************************************Define Inner Variable***********************************************//
    //中断前地址寄存器
        wire[31:0] er_in_d,er_out_d;
        wire er_in_e;
    
    //JK触发器 
        wire jkt_in_j,jkt_in_k;
        wire jkt_out_q;
    
    //优先编码器 
        wire [3:0]pe_in_d;
        wire [1:0]pe_out_d;
        
        reg [3:0]clear;
    
 //*******************************************loginc Implementation***********************************************//
  //指示灯信号产生
       always@(*)//ic_in_is哪一位为1则Led_Sign对应位也为1，对应的led灯亮
           if(!rst_l)
                Led_Sign<=4'h0;
           else
                begin
                    if(ic_in_is[0])
                        Led_Sign[0]<=1'b1;
                    else
                        Led_Sign[0]<=Led_Sign[0];
                      
                     if(ic_in_is[1])
                        Led_Sign[1]<=1'b1;
                     else
                        Led_Sign[1]<=Led_Sign[1];
                        
                     if(ic_in_is[2])
                        Led_Sign[2]<=1'b1;
                      else
                        Led_Sign[2]<=Led_Sign[2];
                        
                     if(ic_in_is[3])
                        Led_Sign[3]<=1'b1;
                     else
                        Led_Sign[3]<=Led_Sign[3];
                 end
    //中断前地址寄存器
        assign er_in_d=ic_in_ra;
        assign er_in_e=INT;
        Reg  ER(clk,rst_l,er_in_d,er_in_e,er_out_d);//暂存中断前的下地址
        assign ic_out_ea=er_out_d;
        
     //显示 
            always@(er_in_e)
                $display($time,,"中断前地址寄存器：er_in_d=%h,er_in_e=%b",er_in_d,er_in_e);
    
    //触发器 
        assign jkt_in_j=INT;
        assign jkt_in_k=ERET;
        JK_Trigger JKT(.Clk(clk),.rst_l(rst_l),.J(jkt_in_j),.K(jkt_in_k),.Q_l(jkt_out_q));
        always@(*)
            $display($time,,"jkt_in_j=%b,jkt_in_k=%b,jkt_out_q=%b",jkt_in_j,jkt_in_k,jkt_out_q);
        
    //INT信号产生
        always@(*)
            begin
                INT<=(Led_Sign[0]|Led_Sign[1]|Led_Sign[2]|Led_Sign[3])&(jkt_out_q);
            end
     //INT信号输出显示
         always@(posedge INT)
            begin
                $display($time,,"中断隐指令执行：INT=%b",INT);
            end
         always@(negedge INT)
            begin
                $display($time,,"中断隐指令执行结束:INT=%b",INT);
            end
            
            
          always@(posedge ERET)
            begin
                $display($time,,"中断返回指令执行：");
            end
           always@(negedge  ERET)
            begin
                $display($time,,"中断返回指令执行结束");
            end
            
    //优先编码器 
        assign pe_in_d=ic_in_is[3:0];
        Pri_Encoer PE(pe_in_d,pe_out_d);
        
    //中断地址产生 
        always@(*)
            case(pe_out_d)
                2'd0:ic_out_ia<=32'h0000_30ac;
                2'd0:ic_out_ia<=32'h0000_3150;
                2'd0:ic_out_ia<=32'h0000_31f4;
                2'd0:ic_out_ia<=32'h0000_0008;
            endcase
        
      //中断程序  清零寄存器 
          assign intr_in_d=pe_out_d;
          assign intr_in_e=INT;
          Reg INTR(clk,rst_l,intr_in_d,intr_in_e,intr_out_d);
         
     //关闭信号灯控制信号 
          always@(*)
            case(intr_out_d)
                2'd0:clear<={3'h0,ERET};
                2'd1:clear<={2'h0,ERET,1'h0};
                2'd2:clear<={1'h0,ERET,2'h0};
                2'd3:clear<={ERET,3'h0};
            endcase
        
        //将中断指示灯关闭
            always@(*)
                case(clear)
                    4'b0001:Led_Sign[0]<=1'b0;
                    4'b0010:Led_Sign[1]<=1'b0;
                    4'b0100:Led_Sign[2]<=1'b0;
                    4'b1000:Led_Sign[3]<=1'b0;
                 endcase
                
endmodule
