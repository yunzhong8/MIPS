`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 20:08:11
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
//  input sys_clk_1_3,
    input clk_1ms,
    input sys_rst_n,
    output reg[31:0] Led_Data
    //output PC
);
//���ж�·ѡ����������һ���Ĵ���
 //*******************************************Define Inner Variable***********************************************//
    parameter R_in_e=1'b1;
    reg [31:0]PC;
    reg [4:0] RF_IN_WA;
    reg [31:0]RF_IN_WD;
    reg [31:0]ALU_IN_B;
    wire [31:0]instruct;
    //PC�Ĵ��� 
    reg [31:0]PCR_IN_PC;
    wire [31:0]pcr_in_pc,pcr_out_pc;
    //���ڼ����� 
    wire[31:0] tcr_out_d;
    reg [9:0]LD_dm_in_wa;
    
    //ָ��洢��
     wire [9:0]ir_in_a;
     wire [31:0]ir_out_d;
    //������ 
    wire [5:0]Op,Func; //����������
    wire Halt,MemtoReg,MemWrite,Beq,Bne,AluSrcB,RegWrite,RegDst; //���������
    wire [3:0]AluOP;
    //�Ĵ�����
    wire rf_in_wre;//�Ĵ������дʹ���źţ�1w��0r

    wire [4:0] rf_in_ra1,rf_in_ra2; //�Ĵ�����Ķ���ַ
    wire [31:0]rf_out_rd1,rf_out_rd2;//�Ĵ������������
   
    wire[4:0]rf_in_wa;//�Ĵ�����д���ַ
    wire[31:0]rf_in_wd;//�Ĵ�����д������
    
    //������ 
   wire [31:0]alu_in_a,alu_in_b;//���������������A,B
   wire [3:0]alu_in_contr;//�������Ŀ����ź�
   wire alu_out_equ;//��������ź�
   wire [31:0]alu_out_rl,alu_out_rh;//���������

    //���ݴ洢�� 
   wire dm_in_wre;//���ݴ洢�� ��д��ʹ���źţ�1w,0r
   wire [9:0] dm_in_rwa;//���ݴ洢�� �Ķ�д��ַ
   wire[31:0]dm_in_wd,dm_out_rd;//���ݴ洢�� ��д���ݣ�������
    
    //������չ��
   wire  se_in_sign;
   wire [31:0]se_out_data;

 //*******************************************loginc Implementation***********************************************//
 
     //$$$$$$$$$$$$$$$�� PC������ ģ����ã�$$$$$$$$$$$$$$$$$$// 
	//ģ�����룺
	   always @(*)
            begin
            if(! sys_rst_n)//��λ
               PCR_IN_PC<=32'h0000_0000;
            else    if( Halt==1'b0)
                        begin
                            if(( Beq&alu_out_equ)||(Bne&&!alu_out_equ)) //��תʱPC�仯
                                begin
                                     PCR_IN_PC<=pcr_out_pc+32'h4+{se_out_data[13:0],instruct[15:0],2'b00};
                                 end
                             else //����PC�仯
                               PCR_IN_PC<=pcr_out_pc+32'h4;
                           end
                     else
                       PCR_IN_PC<=pcr_out_pc;
                end
        assign pcr_in_pc=PCR_IN_PC;
	//ģ����ã�
	    //always@(sys_clk_in,sys_rst_n,pcr_in_pc,R_in_e,pcr_out_pc)
        Reg PCR(sys_clk_in,sys_rst_n,pcr_in_pc,R_in_e,pcr_out_pc);
	//ģ�����������ʾ��
//	    dis_PCR DPCR(sys_clk_in,sys_rst_n,pcr_in_pc,pcr_out_pc);  
 	//#################�� ģ�������#################//
 	   
 	   
 	   
    //$$$$$$$$$$$$$$$�� ���ڼ����� ģ����ã�$$$$$$$$$$$$$$$$$$// 
        //ģ�����룺
        //ģ����ã�
           Counter_Reg T_CR(sys_clk_in,sys_rst_n,1'b1,1'b0,Halt,tcr_out_d);
        //ģ�����������ʾ�� 
 //         always@(*)
 //              $display($time,,"��������tcr_out_d=%d",tcr_out_d);  
 	//#################�� ģ�������#################//
 	
 	
 	   
      
    //$$$$$$$$$$$$$$$�� ����ͣ��ָ��ʱ��洢�������ַÿ��1ms����1 ģ����ã�$$$$$$$$$$$$$$$$$$// 
         always@(posedge clk_1ms,negedge sys_rst_n)
            if(!sys_rst_n)
                LD_dm_in_wa<=10'h80;
            else    if(Halt)
                        begin
                            LD_dm_in_wa<=LD_dm_in_wa+10'h1;
 //                         $display($time,,"Led_Data=%h",Led_Data);
                        end
                    else
                            LD_dm_in_wa<=LD_dm_in_wa;
                      
          //�����ʾ
//         always@(posedge sys_clk_in,negedge sys_rst_n)
//            if(!sys_rst_n)
//                Led_Data<=32'h0;
//             else   if(Halt)
//                        Led_Data<=dm_out_rd;
//                    else
//                        Led_Data<=tcr_out_d ;  
 	//#################�� ģ�������#################//   
 
        
     //$$$$$$$$$$$$$$$��ָ��洢�� ȡ��ָ��  ģ����ã�$$$$$$$$$$$$$$$$$$// 
        //ģ�����룺
           assign ir_in_a=pcr_out_pc[11:2];//��ȡ ָ��洢�� ��ַ
        //ģ����ã�
//          B_Instr_Rom IR(sys_clk_1_3,ir_in_a, instruct);
//          D_Instr_Rom DIR(ir_in_a, instruct);
            Instruct_Memory IR(sys_rst_n,ir_in_a, instruct);//ȡָ��
          //assign instruct=ir_out_d;//��ָ������
        //ģ�����������ʾ�� 
//    	   always@(*)
//            $display($time,,"ir_in_a=%b,pcr_out_pc=%b",ir_in_a,pcr_out_pc[11:2]); 
//        dis_Instruct DI(sys_clk_in,instruct);
 	//#################�� ģ�������#################//   
 	
 	
 	//$$$$$$$$$$$$$$$�� �Ĵ����� ģ����ã�$$$$$$$$$$$$$$$$$$// 
	//ģ�����룺
	    assign rf_in_ra1=instruct[25:21];//��ȡ �Ĵ������ �����ַ1
        assign rf_in_ra2=instruct[20:16];//��ȡ �Ĵ������ �����ַ2
        assign rf_in_wre=RegWrite;//��ȡ �Ĵ������ ��дʹ���ź�
        
        always @(*)//��ȡд���ַ
            if(RegDst)
                RF_IN_WA<=instruct[15:11];
            else
            RF_IN_WA<=instruct[20:16];
        assign rf_in_wa=RF_IN_WA;
    
        always @(*)//��ȡд������
            if(MemtoReg)
                RF_IN_WD<=dm_out_rd;
            else
            RF_IN_WD<=alu_out_rl;
        assign rf_in_wd=RF_IN_WD;//��ȡд������
	//ģ����ã�
	    Reg_File RF(
                sys_clk_in,sys_rst_n,
                rf_in_ra1,rf_in_ra2,
                rf_in_wre,
                rf_in_wa,rf_in_wd,
                rf_out_rd1,rf_out_rd2);
	//ģ�����������ʾ��  
//	        dis_RF DRF(
//                 sys_clk_in,sys_rst_n,
//                 rf_in_ra1,rf_in_ra2,
//                rf_in_wre,
//                rf_in_wa,rf_in_wd,
//                rf_out_rd1,rf_out_rd2,
//                RF_IN_WD);           
 	//#################�� ģ�������#################//  
                    
   
    //$$$$$$$$$$$$$$$�� ������չ�� ģ����ã�$$$$$$$$$$$$$$$$$$// 
	//ģ�����룺
	   assign se_in_sign=instruct[15];
	//ģ����ã�
	    Sign_Extender SE(se_in_sign,se_out_data);
	//ģ�����������ʾ�� 
//     dis_SE DSE(se_in_sign,se_out_data);  
 	//#################�� ģ�������#################//   

     //$$$$$$$$$$$$$$$�� ALU ģ����ã�$$$$$$$$$$$$$$$$$$// 
	//ģ�����룺
	    assign alu_in_a=rf_out_rd1;//��ȡALU���������A
        assign alu_in_contr= AluOP;//��ȡALU�����ź� 
        
        always@(*)//��ȡALU���������B
            if(AluSrcB)
                ALU_IN_B={se_out_data[15:0],instruct[15:0]};
            else
                ALU_IN_B=rf_out_rd2;
        assign alu_in_b=ALU_IN_B;
	//ģ����ã�
	   Arith_Logic_Unit ALU(
                            sys_rst_n,
                            alu_in_a,alu_in_b,
                            alu_in_contr,
                            alu_out_equ,alu_out_rl,alu_out_rh);
	//ģ�����������ʾ��
//	    dis_ALU DALU(
//                   alu_in_a,alu_in_b,
//                   alu_in_contr,
//                   alu_out_equ,alu_out_rl,alu_out_rh,
//                   ALU_IN_B);  
 	//#################�� ģ�������#################//   
   
               
   //$$$$$$$$$$$$$$$�� ���ݴ洢��  ģ����ã�$$$$$$$$$$$$$$$$$$// 
	//ģ�����룺
	    assign dm_in_wre=MemWrite;//��ȡ���ݴ洢��ʹ���źţ�W1,R0
        assign dm_in_rwa=Halt?LD_dm_in_wa:alu_out_rl[11:2];
        assign dm_in_wd=rf_out_rd2;
	//ģ����ã�
//        B_Data_Ram RamD(
//                        sys_clk_in,
//                       dm_in_wre,
//                        dm_in_rwa,dm_in_wd,
//                        dm_out_rd);
    
//         D_Data_Ram DDR(
//                      sys_clk_in,
//                       dm_in_wre,
//                        dm_in_rwa,dm_in_wd,
//                       dm_out_rd);
        Data_Memory DM(
                        sys_clk_in,sys_rst_n,
                        dm_in_wre,
                        dm_in_rwa,dm_in_wd,
                        dm_out_rd);
	//ģ�����������ʾ�� 
//	   dis_DM DDM( 
//                    dm_in_wre,
//                    dm_in_rwa,dm_in_wd,
//                    dm_out_rd); 
 	//#################�� ģ�������#################//   
    
    
   
     //$$$$$$$$$$$$$$$�� ������ ģ����ã�$$$$$$$$$$$$$$$$$$// 
	//ģ�����룺
	   assign Op=instruct[31:26];
       assign Func=instruct[5:0];
	//ģ����ã�
	    Controller_Uint CU(
                        Op, //�����ź�
                        Func,
                    
                        Halt, //����ź�
                        MemtoReg,
                        MemWrite,
                        Beq,
                        Bne,
                        AluOP,
                        AluSrcB,
                        RegWrite,
                        RegDst
                        );
	//ģ�����������ʾ�� 
//	   dis_CU DCU( 
//                sys_clk_in,
//                sys_rst_n,
//                Op, //�����ź�
//                Func,
            
//                Halt, //����ź�
//                MemtoReg,
//                MemWrite,
//                Beq,
//                Bne,
//                AluOP,
//                AluSrcB,
//                RegWrite,
//                RegDst); 
 	//#################�� ģ�������#################//   

    
    

    //
    
    
   
   
    
endmodule

