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
input[31:0]ic_in_ra,//�����ַ

output reg INT,
output reg [31:0]ic_out_ia,//����ж��ӳ����ַ
output[31:0]ic_out_ea,//����жϽ������ָ���ַ
output reg[3:0]Led_Sign

    );
 //*******************************************Define Inner Variable***********************************************//
    //�ж�ǰ��ַ�Ĵ���
        wire[31:0] er_in_d,er_out_d;
        wire er_in_e;
    
    //JK������ 
        wire jkt_in_j,jkt_in_k;
        wire jkt_out_q;
    
    //���ȱ����� 
        wire [3:0]pe_in_d;
        wire [1:0]pe_out_d;
        
        reg [3:0]clear;
    
 //*******************************************loginc Implementation***********************************************//
  //ָʾ���źŲ���
       always@(*)//ic_in_is��һλΪ1��Led_Sign��ӦλҲΪ1����Ӧ��led����
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
    //�ж�ǰ��ַ�Ĵ���
        assign er_in_d=ic_in_ra;
        assign er_in_e=INT;
        Reg  ER(clk,rst_l,er_in_d,er_in_e,er_out_d);//�ݴ��ж�ǰ���µ�ַ
        assign ic_out_ea=er_out_d;
        
     //��ʾ 
            always@(er_in_e)
                $display($time,,"�ж�ǰ��ַ�Ĵ�����er_in_d=%h,er_in_e=%b",er_in_d,er_in_e);
    
    //������ 
        assign jkt_in_j=INT;
        assign jkt_in_k=ERET;
        JK_Trigger JKT(.Clk(clk),.rst_l(rst_l),.J(jkt_in_j),.K(jkt_in_k),.Q_l(jkt_out_q));
        always@(*)
            $display($time,,"jkt_in_j=%b,jkt_in_k=%b,jkt_out_q=%b",jkt_in_j,jkt_in_k,jkt_out_q);
        
    //INT�źŲ���
        always@(*)
            begin
                INT<=(Led_Sign[0]|Led_Sign[1]|Led_Sign[2]|Led_Sign[3])&(jkt_out_q);
            end
     //INT�ź������ʾ
         always@(posedge INT)
            begin
                $display($time,,"�ж���ָ��ִ�У�INT=%b",INT);
            end
         always@(negedge INT)
            begin
                $display($time,,"�ж���ָ��ִ�н���:INT=%b",INT);
            end
            
            
          always@(posedge ERET)
            begin
                $display($time,,"�жϷ���ָ��ִ�У�");
            end
           always@(negedge  ERET)
            begin
                $display($time,,"�жϷ���ָ��ִ�н���");
            end
            
    //���ȱ����� 
        assign pe_in_d=ic_in_is[3:0];
        Pri_Encoer PE(pe_in_d,pe_out_d);
        
    //�жϵ�ַ���� 
        always@(*)
            case(pe_out_d)
                2'd0:ic_out_ia<=32'h0000_30ac;
                2'd0:ic_out_ia<=32'h0000_3150;
                2'd0:ic_out_ia<=32'h0000_31f4;
                2'd0:ic_out_ia<=32'h0000_0008;
            endcase
        
      //�жϳ���  ����Ĵ��� 
          assign intr_in_d=pe_out_d;
          assign intr_in_e=INT;
          Reg INTR(clk,rst_l,intr_in_d,intr_in_e,intr_out_d);
         
     //�ر��źŵƿ����ź� 
          always@(*)
            case(intr_out_d)
                2'd0:clear<={3'h0,ERET};
                2'd1:clear<={2'h0,ERET,1'h0};
                2'd2:clear<={1'h0,ERET,2'h0};
                2'd3:clear<={ERET,3'h0};
            endcase
        
        //���ж�ָʾ�ƹر�
            always@(*)
                case(clear)
                    4'b0001:Led_Sign[0]<=1'b0;
                    4'b0010:Led_Sign[1]<=1'b0;
                    4'b0100:Led_Sign[2]<=1'b0;
                    4'b1000:Led_Sign[3]<=1'b0;
                 endcase
                
endmodule
