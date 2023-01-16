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
input [4:0] rf_in_ra1,//�������ݵĵ�ַ
input [4:0] rf_in_ra2,//

input rf_in_wre,//дʹ���ź�

input [4:0]rf_in_wa,// д�����ݵĵ�ַ
input [31:0]rf_in_wd,//д������

output reg[31:0]rf_out_rd1,//�����Ĵ����������
output reg[31:0]rf_out_rd2
    );
    
    reg[31:0] RF_Mem[31:0];//�Ĵ�������
    reg [4:0] i=0;
   
    always @(posedge clk ,negedge rst_l)//д��Ĵ�����
    begin
         if(!rst_l)//clk
         ;
        else    
             begin
                if(rf_in_wre==1'b1)//����д������ʱ
                     begin
                        RF_Mem[rf_in_wa]=rf_in_wd;//�˴�д����<=�Ǵ���ģ�����һ��ʱ�����壬����=���ǶԵ�Ϊʲô��ʱ���·��Ӧ����<=
//                        $display($time,"��� д����ʱ��д��ʹ���źţ�rf_in_wre=%h,д���ݣ�rf_in_wd=%h,�Ĵ������Ӧ��Ԫ��д��Ԫ��ֵ��RF_Mem[%h]=%h",rf_in_wre,rf_in_wd,rf_in_wa, RF_Mem[rf_in_wa]);
                      end                         
             end
      end
      
      
      always @(*)//����Ĵ�����
           if(!rst_l)//��λ
                begin
                    $readmemh("D:/Documents/Hardware_verlog/MIPS_CPU/RF_data.txt",RF_Mem);//����ָ�� 
                    rf_out_rd1<=32'h0000_0000;
                    rf_out_rd2<=32'h0000_0000;
                    //ɾ��
//                     $display($time,,"��ʼ����Ĵ����ֵ");
//                     repeat(32)
//                         begin
//                                $display($time,,"RF_Mem[%h]=%h",i,RF_Mem[i]);
//                                 i=i+5'h1;
//                        end
                     //ɾ��
                end
            else
                begin//������
                       rf_out_rd1 <=RF_Mem[rf_in_ra1];//��ȡR1��<=Ҳ�Ǵ��,����=
                       rf_out_rd2 <= RF_Mem[rf_in_ra2];//��ȡR2
//                       $display($time,"��� ������1ʱ������������ݣ�rf_out_rd1=%h,��Ӧ������Ԫ�ڱ����ֵ��RF_Mem[%h]=%h",rf_out_rd1,rf_in_ra1,RF_Mem[rf_in_ra1]);
//                       $display($time,"��� ������2ʱ������������ݣ�rf_out_rd2=%h,��Ӧ������Ԫ�ڱ����ֵ��RF_Mem[%h]=%h",rf_out_rd2,rf_in_ra2,RF_Mem[rf_in_ra2]);
//                       i=5'h0;
//                       $display($time,,"�Ĵ������е�ֵ");
//                       repeat(32)
//                            begin
//                                $monitor($time,,"RF_Mem[%h]=%h",i,RF_Mem[i]);
//                                i=i+5'h1;
//                            end 
                  end    
                         
endmodule
