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
//所有多路选择器都带有一个寄存器
 //*******************************************Define Inner Variable***********************************************//
    parameter R_in_e=1'b1;
    reg [31:0]PC;
    reg [4:0] RF_IN_WA;
    reg [31:0]RF_IN_WD;
    reg [31:0]ALU_IN_B;
    wire [31:0]instruct;
    //PC寄存器 
    reg [31:0]PCR_IN_PC;
    wire [31:0]pcr_in_pc,pcr_out_pc;
    //周期计数器 
    wire[31:0] tcr_out_d;
    reg [9:0]LD_dm_in_wa;
    
    //指令存储器
     wire [9:0]ir_in_a;
     wire [31:0]ir_out_d;
    //控制器 
    wire [5:0]Op,Func; //控制器输入
    wire Halt,MemtoReg,MemWrite,Beq,Bne,AluSrcB,RegWrite,RegDst; //控制器输出
    wire [3:0]AluOP;
    //寄存器组
    wire rf_in_wre;//寄存器组读写使能信号，1w，0r

    wire [4:0] rf_in_ra1,rf_in_ra2; //寄存器组的读地址
    wire [31:0]rf_out_rd1,rf_out_rd2;//寄存器组读出数据
   
    wire[4:0]rf_in_wa;//寄存器组写入地址
    wire[31:0]rf_in_wd;//寄存器组写入数据
    
    //运算器 
   wire [31:0]alu_in_a,alu_in_b;//运算器参与运算的A,B
   wire [3:0]alu_in_contr;//运算器的控制信号
   wire alu_out_equ;//等于输出信号
   wire [31:0]alu_out_rl,alu_out_rh;//运算结果输出

    //数据存储器 
   wire dm_in_wre;//数据存储器 的写读使能信号，1w,0r
   wire [9:0] dm_in_rwa;//数据存储器 的读写地址
   wire[31:0]dm_in_wd,dm_out_rd;//数据存储器 的写数据，读数据
    
    //符号扩展器
   wire  se_in_sign;
   wire [31:0]se_out_data;

 //*******************************************loginc Implementation***********************************************//
 
     //$$$$$$$$$$$$$$$（ PC产生器 模块调用）$$$$$$$$$$$$$$$$$$// 
	//模块输入：
	   always @(*)
            begin
            if(! sys_rst_n)//复位
               PCR_IN_PC<=32'h0000_0000;
            else    if( Halt==1'b0)
                        begin
                            if(( Beq&alu_out_equ)||(Bne&&!alu_out_equ)) //跳转时PC变化
                                begin
                                     PCR_IN_PC<=pcr_out_pc+32'h4+{se_out_data[13:0],instruct[15:0],2'b00};
                                 end
                             else //正常PC变化
                               PCR_IN_PC<=pcr_out_pc+32'h4;
                           end
                     else
                       PCR_IN_PC<=pcr_out_pc;
                end
        assign pcr_in_pc=PCR_IN_PC;
	//模块调用：
	    //always@(sys_clk_in,sys_rst_n,pcr_in_pc,R_in_e,pcr_out_pc)
        Reg PCR(sys_clk_in,sys_rst_n,pcr_in_pc,R_in_e,pcr_out_pc);
	//模块输入输出显示：
//	    dis_PCR DPCR(sys_clk_in,sys_rst_n,pcr_in_pc,pcr_out_pc);  
 	//#################（ 模块结束）#################//
 	   
 	   
 	   
    //$$$$$$$$$$$$$$$（ 周期计数器 模块调用）$$$$$$$$$$$$$$$$$$// 
        //模块输入：
        //模块调用：
           Counter_Reg T_CR(sys_clk_in,sys_rst_n,1'b1,1'b0,Halt,tcr_out_d);
        //模块输入输出显示： 
 //         always@(*)
 //              $display($time,,"周期数：tcr_out_d=%d",tcr_out_d);  
 	//#################（ 模块结束）#################//
 	
 	
 	   
      
    //$$$$$$$$$$$$$$$（ 发生停机指令时候存储器输入地址每过1ms增加1 模块调用）$$$$$$$$$$$$$$$$$$// 
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
                      
          //输出显示
//         always@(posedge sys_clk_in,negedge sys_rst_n)
//            if(!sys_rst_n)
//                Led_Data<=32'h0;
//             else   if(Halt)
//                        Led_Data<=dm_out_rd;
//                    else
//                        Led_Data<=tcr_out_d ;  
 	//#################（ 模块结束）#################//   
 
        
     //$$$$$$$$$$$$$$$（指令存储器 取出指令  模块调用）$$$$$$$$$$$$$$$$$$// 
        //模块输入：
           assign ir_in_a=pcr_out_pc[11:2];//获取 指令存储器 地址
        //模块调用：
//          B_Instr_Rom IR(sys_clk_1_3,ir_in_a, instruct);
//          D_Instr_Rom DIR(ir_in_a, instruct);
            Instruct_Memory IR(sys_rst_n,ir_in_a, instruct);//取指令
          //assign instruct=ir_out_d;//传指令总线
        //模块输入输出显示： 
//    	   always@(*)
//            $display($time,,"ir_in_a=%b,pcr_out_pc=%b",ir_in_a,pcr_out_pc[11:2]); 
//        dis_Instruct DI(sys_clk_in,instruct);
 	//#################（ 模块结束）#################//   
 	
 	
 	//$$$$$$$$$$$$$$$（ 寄存器组 模块调用）$$$$$$$$$$$$$$$$$$// 
	//模块输入：
	    assign rf_in_ra1=instruct[25:21];//获取 寄存器组的 读入地址1
        assign rf_in_ra2=instruct[20:16];//获取 寄存器组的 读入地址2
        assign rf_in_wre=RegWrite;//获取 寄存器组的 读写使能信号
        
        always @(*)//获取写入地址
            if(RegDst)
                RF_IN_WA<=instruct[15:11];
            else
            RF_IN_WA<=instruct[20:16];
        assign rf_in_wa=RF_IN_WA;
    
        always @(*)//获取写入数据
            if(MemtoReg)
                RF_IN_WD<=dm_out_rd;
            else
            RF_IN_WD<=alu_out_rl;
        assign rf_in_wd=RF_IN_WD;//获取写入数据
	//模块调用：
	    Reg_File RF(
                sys_clk_in,sys_rst_n,
                rf_in_ra1,rf_in_ra2,
                rf_in_wre,
                rf_in_wa,rf_in_wd,
                rf_out_rd1,rf_out_rd2);
	//模块输入输出显示：  
//	        dis_RF DRF(
//                 sys_clk_in,sys_rst_n,
//                 rf_in_ra1,rf_in_ra2,
//                rf_in_wre,
//                rf_in_wa,rf_in_wd,
//                rf_out_rd1,rf_out_rd2,
//                RF_IN_WD);           
 	//#################（ 模块结束）#################//  
                    
   
    //$$$$$$$$$$$$$$$（ 符号扩展器 模块调用）$$$$$$$$$$$$$$$$$$// 
	//模块输入：
	   assign se_in_sign=instruct[15];
	//模块调用：
	    Sign_Extender SE(se_in_sign,se_out_data);
	//模块输入输出显示： 
//     dis_SE DSE(se_in_sign,se_out_data);  
 	//#################（ 模块结束）#################//   

     //$$$$$$$$$$$$$$$（ ALU 模块调用）$$$$$$$$$$$$$$$$$$// 
	//模块输入：
	    assign alu_in_a=rf_out_rd1;//获取ALU参与运算的A
        assign alu_in_contr= AluOP;//获取ALU控制信号 
        
        always@(*)//获取ALU参与运算的B
            if(AluSrcB)
                ALU_IN_B={se_out_data[15:0],instruct[15:0]};
            else
                ALU_IN_B=rf_out_rd2;
        assign alu_in_b=ALU_IN_B;
	//模块调用：
	   Arith_Logic_Unit ALU(
                            sys_rst_n,
                            alu_in_a,alu_in_b,
                            alu_in_contr,
                            alu_out_equ,alu_out_rl,alu_out_rh);
	//模块输入输出显示：
//	    dis_ALU DALU(
//                   alu_in_a,alu_in_b,
//                   alu_in_contr,
//                   alu_out_equ,alu_out_rl,alu_out_rh,
//                   ALU_IN_B);  
 	//#################（ 模块结束）#################//   
   
               
   //$$$$$$$$$$$$$$$（ 数据存储器  模块调用）$$$$$$$$$$$$$$$$$$// 
	//模块输入：
	    assign dm_in_wre=MemWrite;//获取数据存储器使能信号，W1,R0
        assign dm_in_rwa=Halt?LD_dm_in_wa:alu_out_rl[11:2];
        assign dm_in_wd=rf_out_rd2;
	//模块调用：
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
	//模块输入输出显示： 
//	   dis_DM DDM( 
//                    dm_in_wre,
//                    dm_in_rwa,dm_in_wd,
//                    dm_out_rd); 
 	//#################（ 模块结束）#################//   
    
    
   
     //$$$$$$$$$$$$$$$（ 控制器 模块调用）$$$$$$$$$$$$$$$$$$// 
	//模块输入：
	   assign Op=instruct[31:26];
       assign Func=instruct[5:0];
	//模块调用：
	    Controller_Uint CU(
                        Op, //输入信号
                        Func,
                    
                        Halt, //输出信号
                        MemtoReg,
                        MemWrite,
                        Beq,
                        Bne,
                        AluOP,
                        AluSrcB,
                        RegWrite,
                        RegDst
                        );
	//模块输入输出显示： 
//	   dis_CU DCU( 
//                sys_clk_in,
//                sys_rst_n,
//                Op, //输入信号
//                Func,
            
//                Halt, //输出信号
//                MemtoReg,
//                MemWrite,
//                Beq,
//                Bne,
//                AluOP,
//                AluSrcB,
//                RegWrite,
//                RegDst); 
 	//#################（ 模块结束）#################//   

    
    

    //
    
    
   
   
    
endmodule

