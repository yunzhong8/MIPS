`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 20:46:18
// Design Name: 
// Module Name: CPU
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


module CPU(
    input sys_clk_in,
    input clk_1ms,
    input sys_rst_n,
    output reg [31:0]Led_Data
    );
//����: sys_clk_in��CPU����ʱ�����壬clk_1ms��ͣ��ʱ�洢�������ֵ��ʱ�����壬sys_rst_n��CPU��λ�ź�
//�����Led_Data��CPU�洢�������ֵ��������Ľӿ�
//���ܣ����ú�IDM(ָ�����ݴ洢��)�е�ָ�����������ָ�������Ҫ���Ϊsort������IDM���ڸ�λʱ��ʼ����sort����ָ������н��������IDM:80h��86h�е�����
//��������
    //����ĵط��У�����λ�����Ƕ��嵼�����ݴ��������λ����ûλ��� 
    //�ӿڴ�������������д���� 
    //�������Ƕ����� 
    //ϵͳ������$display������ȶ�ǰ���ȶ�������ݱ仯,��monitor�ڹ۲��ģ��Ľӿڵ�ֵ����ʹ�ã����Ի�����displya 
    //monitor�������ڴ洢���޸������������� 
    //�洢�����߼�����ȡ�Ǻ�ʱ���޹ص�,д��ʱ���й� 
    //��дrepeat���� display��Mem[%d]=%h,i,Mem[i]��;i=i+5'h1;ע�����㣺i+����ֵ�ǵ�д��λ����Ȼ�Ͳ���ִ�У���=����<=
   
     parameter R_in_e=1'b1;//��ʹ���źŵļĴ�����ʹ���ź�
    //*******************************************Define Inner Variable�������ڲ�������***********************************************//
        //PC ģ���������
            wire [31:0]PC_in_d,PC_out_d;
            wire PC_in_e;
        //���ڼ����� ģ���������
            wire[31:0] tcr_out_d;
            wire tcr_in_stop;
            reg [9:0]LD_dm_in_wa;
        
        //ָ�����ݴ洢�� ģ���������
            wire [9:0]idm_in_rwa;
            wire idm_in_we,idm_in_re;
            wire [31:0] idm_in_wd,idm_out_rd;
        
        //ָ��Ĵ���,���ݼĴ��� ģ���������
            wire[31:0]IR_in_d,DR_in_d,IR_out_d,DR_out_d;
            wire IR_in_e;
        //�Ĵ����� ģ���������
             wire [4:0]rf_in_ra1,rf_in_ra2;
             wire rf_in_wre;
             wire [4:0]rf_in_wa;
             wire [31:0]rf_in_wd;
             wire[31:0]rf_out_rd1,rf_out_rd2;
         
         //�Ĵ���������ļĴ��� ģ���������
             wire[31:0] RA_in_d,RB_in_d,RA_out_d,RB_out_d;
         //������չ�� ģ���������
             wire se_in_sign;
             wire [31:0]se_out_data;
         
         //ALU�๦�������� ģ���������
             wire[31:0] alu_in_a;
             reg [31:0]alu_in_b;
             wire [3:0]alu_in_contr;
             wire alu_out_equ;
             wire[31:0] alu_out_rl,alu_out_rh;
         
         //�������Ĵ��� ģ���������
             wire [31:0]RR_in_d,RR_out_d;
             
         //������ ģ���������
             wire [5:0]Op;wire[5:0]Func;
             wire Bne,Beq,MemRead, MemWrite,RegWrite, PcWrite,IrWrite,RegDst,MemToReg,AluSrcA,PCsrc,lorD; 
             wire [1:0]AluSrcB;
             wire[3:0]ALU_OP,mini_address;
     
     
     //*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//
        //$$$$$$$$$$$$$$$��PC�Ĵ���  ģ����ã�$$$$$$$$$$$$$$$$$$//  
             assign PC_in_e=PcWrite|(Beq&alu_out_equ)|(Bne&~alu_out_equ);
             assign PC_in_d=PCsrc?RR_out_d:alu_out_rl;
             Reg PC(sys_clk_in,sys_rst_n,PC_in_d,PC_in_e,PC_out_d); 
              //    dis_PCR DPCR(sys_clk_in,sys_rst_n,PC_in_d,PC_out_d);
              //    always@(*)
              //    $display($time,,"PC_in_e=%b",PC_in_e);
         //#################��PC�Ĵ��� ģ�������#################// 
            
        
         //$$$$$$$$$$$$$$$�����ڼ����� ģ����ã�$$$$$$$$$$$$$$$$$$//  
               assign tcr_in_stop=(mini_address==4'hd)?1'b1:1'b0;
               Counter_Reg T_CR(sys_clk_in,sys_rst_n,1'b1,1'b0,tcr_in_stop,tcr_out_d);
         //#################�� ģ�������#################//
        
             
         //$$$$$$$$$$$$$$$��ͣ�� ģ����ã�$$$$$$$$$$$$$$$$$$//
            //����ͣ��ָ��ʱ��洢�������ַÿ��1ms����1
                 always@(posedge clk_1ms,negedge sys_rst_n)
                    if(!sys_rst_n)
                        LD_dm_in_wa<=10'h80;
                    else    if(tcr_in_stop)
                                begin
                                    LD_dm_in_wa<=LD_dm_in_wa+10'h1;
                                // $display($time,," LD_dm_in_wa=%h,Led_Data=%h", LD_dm_in_wa,Led_Data);
                                    
                                end
                            else
                                    LD_dm_in_wa<=LD_dm_in_wa;
                      
              //ͣ��������洢����ֵ
                     always@(posedge sys_clk_in,negedge sys_rst_n)
                        if(!sys_rst_n)
                            Led_Data<=32'h0;
                         else   if(tcr_in_stop)
                                    Led_Data<=idm_out_rd;
                                else
                                    Led_Data<=32'h0; 
         //#################�� ģ�������#################//    
        
                          
         //$$$$$$$$$$$$$$$��ָ�����ݴ洢��  ģ����ã�$$$$$$$$$$$$$$$$$$//
               assign idm_in_rwa=tcr_in_stop?(LD_dm_in_wa):(lorD?RR_out_d[11:2]:PC_out_d[11:2]);
               assign idm_in_wd=RB_out_d;
               assign idm_in_we=MemWrite;
               assign idm_in_re=tcr_in_stop?1'b1:MemRead;
               Instruct_Datat_Mem IDM(
                                 sys_clk_in,sys_rst_n,
                                 idm_in_rwa,
                                 idm_in_wd,
                                 idm_in_we,
                                 idm_in_re,
                                 idm_out_rd
                                    );
             //ģ�����������ʾ                           
//                    dis_IDM DIDM(
//                     sys_clk_in,sys_rst_n,
//                                     idm_in_rwa,
//                                     idm_in_wd,
//                                     idm_in_we,
//                                     idm_in_re,
//                                     idm_out_rd,
//                                     RB_out_d);        
         //#################��  ģ�������#################//
         
            
          //$$$$$$$$$$$$$$$�� ָ��Ĵ���  ģ����ã�$$$$$$$$$$$$$$$$$$//
            assign IR_in_e=IrWrite;
            assign IR_in_d=idm_out_rd;
           
            Reg IR(sys_clk_in,sys_rst_n,IR_in_d,IR_in_e,IR_out_d);
            //ģ�����������ʾ 
//                  dis_Instruct DI(sys_clk_in,IR_out_d);       
          //#################�� ģ�������#################//
          
          
            //$$$$$$$$$$$$$$$�� ���ݼĴ���  ģ����ã�$$$$$$$$$$$$$$$$$$// 
              assign DR_in_d=idm_out_rd;
              Reg DR(sys_clk_in,sys_rst_n,DR_in_d,R_in_e,DR_out_d);
              
             //ģ�����������ʾ 
//                    always@(*)
//                         $display($time,,"���ݼĴ���:DR_in_e=%b��DR_out_d=%h",R_in_e,DR_out_d);  
            //#################�� ģ�������#################//
                     
            
             //$$$$$$$$$$$$$$$�� �Ĵ�����  ģ����ã�$$$$$$$$$$$$$$$$$$//  
                assign rf_in_ra1=IR_out_d[25:21];
                assign rf_in_ra2=IR_out_d[20:16];
                assign rf_in_wre=RegWrite;
                assign rf_in_wa=RegDst?IR_out_d[15:11]:IR_out_d[20:16];
                assign rf_in_wd=MemToReg?DR_out_d:RR_out_d;
      
                Reg_File RF(
                         sys_clk_in,sys_rst_n,
                         rf_in_ra1,//�������ݵĵ�ַ
                         rf_in_ra2,//
                        
                         rf_in_wre,//дʹ���ź�
                        
                        rf_in_wa,// д�����ݵĵ�ַ
                        rf_in_wd,//д������
                        
                        rf_out_rd1,//�����Ĵ����������
                        rf_out_rd2
                        );
               //ģ�����������ʾ 
//                    always@(*)
//                        $display($time,,"�Ĵ�����:rf_in_ra1=%h��rf_in_ra2=%h��rf_in_wre=%h��rf_in_wa=%h",rf_in_ra1,rf_in_ra2,rf_in_wre,rf_in_wa);
//                    always@(*)
//                        $display($time,,"�Ĵ�����:rf_out_rd1=%h�� rf_out_rd2=%h��", rf_out_rd1,rf_out_rd2); 
            //#################�� ģ�������#################//
                          
           
          //$$$$$$$$$$$$$$$�� A�Ĵ��� ģ����ã�$$$$$$$$$$$$$$$$$$//
                assign RA_in_d=rf_out_rd1;
                Reg RA(sys_clk_in,sys_rst_n,RA_in_d,R_in_e,RA_out_d);
                
                //ģ�����������ʾ 
//                  always@(*)
//                        $display($time,,"A�Ĵ�����RA_in_d=%h��RR_in_e=%h,RA_out_d=%h",RA_in_d,R_in_e,RA_out_d);   
         //#################�� ģ�������#################//    
            
                    
         //$$$$$$$$$$$$$$$�� B�Ĵ��� ģ����ã�$$$$$$$$$$$$$$$$$$// 
               assign RB_in_d=rf_out_rd2;
               
               Reg RB(sys_clk_in,sys_rst_n,RB_in_d,R_in_e,RB_out_d);
               //ģ�����������ʾ  
//                   always@(*)
//                        $display($time,,"B�Ĵ�����RB_in_d=%h��RR_in_e=%h,RB_out_d=%h",RB_in_d,R_in_e,RB_out_d);  
        //#################�� ģ�������#################//
        
             
        //$$$$$$$$$$$$$$$�� ������չ�� ģ����ã�$$$$$$$$$$$$$$$$$$//
             assign se_in_sign=IR_out_d[15];
             Sign_Extender SE(se_in_sign, se_out_data);   
        //#################�� ģ�������#################// 
           
       
        //$$$$$$$$$$$$$$$��ALU ģ����ã�$$$$$$$$$$$$$$$$$$//
             assign alu_in_a=AluSrcA?RA_out_d:PC_out_d;
             always@(*)
               case(AluSrcB)
                   2'b00:alu_in_b<=rf_out_rd2;
                   2'b01:alu_in_b<=32'h4;
                   2'b10:alu_in_b<={se_out_data,IR_out_d[15:0]};
                   2'b11:alu_in_b<={se_out_data[13:0],IR_out_d[15:0],2'b00};
               endcase
            
           assign alu_in_contr=ALU_OP;
            Arith_Logic_Unit ALU
                                (sys_rst_n,
                                
                                 alu_in_a,//�μ��������A
                                 alu_in_b,//�μ��������B
                                 alu_in_contr,//���㹦�ܿ���
                                
                                 alu_out_equ,
                                 alu_out_rl,//���ֽ�
                                 alu_out_rh//���ֽ�
                               );
          //ģ�����������ʾ  
//               always@(*)
//               begin
//                    $monitor($time,,"������: alu_in_a=%h��alu_in_b=%h�� alu_in_contr=%h,alu_out_equ=%h", alu_in_a,alu_in_b, alu_in_contr,alu_out_equ);
//                    $monitor($time,,"������: alu_out_rl=%h��alu_out_rh=%h", alu_out_rl,alu_out_rh);
//                end    
        //#################�� ģ�������#################//    
          
            
        
        //$$$$$$$$$$$$$$$���������Ĵ���  ģ����ã�$$$$$$$$$$$$$$$$$$// 
             assign RR_in_d=alu_out_rl;
             Reg RR(sys_clk_in,sys_rst_n,RR_in_d,R_in_e,RR_out_d);
             
             //ģ�����������ʾ  
//              always@(*)
//                  $display($time,,"����������Ĵ�����RR_in_d=%h��RR_in_e=%h,RR_out_d=%h",RR_in_d,R_in_e,RR_out_d);  
        //#################�� ģ�������#################//
            
        
        
        //$$$$$$$$$$$$$$$��������  ģ����ã�$$$$$$$$$$$$$$$$$$//
             assign Op=IR_out_d[31:26];
             assign Func=IR_out_d[5:0];
             Controller_Uint CU(
                                sys_clk_in,
                                sys_rst_n,
                                Op,Func,
                                
                                 Bne,
                                 Beq,
                                 MemRead,
                                 MemWrite,
                                 RegWrite,
                                 PcWrite,
                                 IrWrite,
                                 RegDst,
                                 MemToReg,
                                 AluSrcB,
                                 AluSrcA,
                                 PCsrc,
                                 lorD,
                                 ALU_OP,
                                 mini_address
                                    );
              //ģ�����������ʾ
//                 always@(*)
//                     begin
//                        $display($time,,"ALU_OP=%h",ALU_OP);
//                        $display($time,,"��������lorD=%b,PCsrc=%b,AluSrcA=%b,AluSrcB=%b, MemToReg=%b,RegDst=%b,IrWrite=%b,",lorD,PCsrc,AluSrcA,AluSrcB, MemToReg,RegDst,IrWrite);
//                        $display($time,," PcWrite=%b,RegWrite=%b,MemWrite=%b,MemRead=%b,Beq=%b,Bne=%b",PcWrite,RegWrite,MemWrite,MemRead,Beq,Bne);
//                     end   
        //#################�� ģ�������#################//    
           
       
             
    
    
endmodule
