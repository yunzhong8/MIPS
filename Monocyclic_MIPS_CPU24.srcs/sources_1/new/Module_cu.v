`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/08 23:42:12
// Design Name: 
// Module Name: Module_cu
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

`include "defines.v"
module Module_cu(
input wire rst_l,
input wire[`OpBus]op,
input wire[`FuncBus]func,
output reg[3:0]aluop,
output reg[`SignBus]sign
    );
    //20'd0000_0000_0000_0000_0000
    parameter
              //R������ָ�ͣ��ָ��
               SignR=`SignLen'b0000_0000_1100_0000_0000,
               SignSyscal=`SignLen'b0000_0000_0000_0000_0001,
               //I��O��չָ�I�ͷ�����չ
               SignIZ=`SignLen'b0100_0000_1000_0000_0000,
               SignIS=`SignLen'b0110_0000_1000_0000_0000,
                //�ô�ָ������ź�
               SignLw=`SignLen'b0110_0000_1010_0000_0000,
               SignSw=`SignLen'b0110_1000_0000_0000_0000,
               //��ָ֧������ź�
               SignBeq=`SignLen'b0001_0000_0000_1000_0000,
               SignBne=`SignLen'b0001_0000_0000_0100_0000,
               //��תָ������ź�
               SignJr=`SignLen'b0000_0000_0000_0000_1000,
               SignJ=`SignLen'b0000_0000_0000_0000_0100,
               SignJal=`SignLen'b0000_0000_1000_0000_0110;
              
               
              
    
    always @(*)
        if(!rst_l)begin
             aluop<=`AluOpLen'd0;
             sign<=`SignLen'd0;
          end
        else
            case(op)
                `Rtype:
                         case(func)
                             //�߼�yunsuan
                            `FuncAnd:begin aluop<=`AluOpAnd;
                                    sign <=SignR;
                                    end
                            `FuncOr:begin aluop<=`AluOpOr;
                                    sign <=SignR;
                                    end
                            `FuncXor:begin aluop<=`AluOpXor;
                                     sign <=SignR;
                                     end
                             `FuncNor:begin aluop<=`AluOpNor;
                                     sign <=SignR;
                                     end
                             //��������
                            `FuncAdd:begin aluop<=`AluOpAdd;
                                      sign <=SignR;
                                     end
                            `FuncAddu:begin aluop<=`AluOpAdd;
                                       sign <=SignR;
                                      end
                            `FuncSub:begin aluop<=`AluOpSub;
                                      sign <=SignR;
                                     end
                             //�Ƚ�����
                            `FuncSlt:begin aluop<=`AluOpSlt;
                                      sign <=SignR;
                                     end
                             `FuncSltu:begin aluop<=`AluOpSltu;
                                      sign <=SignR;
                                     end
                              //��λ
                            `FuncSll:begin aluop<=`AluOpSll;
                                      sign <=SignR;
                                     end
                            `FuncSra:begin aluop<=`AluOpSra;
                                     sign <=SignR;
                                     end
                             `FuncSrl: begin aluop<=`AluOpSrl;
                                     sign <=SignR;
                                     end
                            //ͣ��
                            `FuncSyscall:begin aluop<=`AluOpAdd;
                                         sign <=SignSyscal;
                                        end
                             //jr
                             `FuncJr:begin aluop<=`AluOpAdd;
                                           sign<=SignJr;
                                        end
                        endcase
                  
                 //I���߼�����
                 `OpAndi:begin
                           aluop<=`AluOpAnd;
                           sign<=SignIZ;
                       end
                 `OpOri:begin
                           aluop<=`AluOpOr;
                           sign<=SignIZ;
                       end
                 `OpXori:begin
                           aluop<=`AluOpXor;
                           sign<=SignIZ;
                       end
                 `OpLui:begin
                           aluop<=`AluOpLui;
                           sign<=SignIZ;
                       end
                 //I������
                 `OpAddi:begin
                           aluop<=`AluOpAdd;
                           sign<=SignIS;
                       end
                 `OpAddiu:begin
                           aluop<=`AluOpAdd;
                           sign<=SignIS;
                       end
                 //��תָ�� 
                 `OpJ:sign<= SignJ;
                 `OpJal:sign<=SignJal;
                
                 //��ָ֧��
                 `OpBeq: begin
                           aluop<=`AluOpEqu;
                           sign<=SignBeq;
                       end
                   
                 `OpBne: begin
                           aluop<=`AluOpEqu;
                           sign<=SignBne;
                       end
                 //�ô�ָ��
                 `OpSw:begin
                           aluop<=`AluOpAdd;
                           sign<=SignSw;
                       end
                 `OpLw:begin
                           aluop<=`AluOpAdd;
                           sign<=SignLw;
                       end
             endcase
             
            
             
                     
                 
            
endmodule
