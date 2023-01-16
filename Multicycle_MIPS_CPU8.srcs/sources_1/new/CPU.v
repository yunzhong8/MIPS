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
//输入: sys_clk_in：CPU运行时钟脉冲，clk_1ms：停机时存储器输出数值的时钟脉冲，sys_rst_n：CPU复位信号
//输出：Led_Data：CPU存储器输出数值向外输出的接口
//功能：设置好IDM(指令数据存储器)中的指令，即可以运行指令。本处主要设计为sort程序，在IDM中在复位时初始化好sort程序指令，在运行结束后输出IDM:80h：86h中的数据
//所犯错误：
    //错误的地方有：数据位宽忘记定义导致数据传输错误，有位宽传给没位宽的 
    //接口传递两方变量名写错了 
    //变量忘记定义了 
    //系统函数；$display会输出稳定前和稳定后的数据变化,而monitor在观察各模块的接口的值不好使用，所以还是用displya 
    //monitor可以用在存储器修改输出上这个好用 
    //存储器的逻辑：读取是和时钟无关的,写和时钟有关 
    //在写repeat（） display（Mem[%d]=%h,i,Mem[i]）;i=i+5'h1;注意两点：i+的数值记得写好位宽，不然就不会执行，用=不是<=
   
     parameter R_in_e=1'b1;//无使能信号的寄存器的使能信号
    //*******************************************Define Inner Variable（定义内部变量）***********************************************//
        //PC 模块变量定义
            wire [31:0]PC_in_d,PC_out_d;
            wire PC_in_e;
        //周期计数器 模块变量定义
            wire[31:0] tcr_out_d;
            wire tcr_in_stop;
            reg [9:0]LD_dm_in_wa;
        
        //指令数据存储器 模块变量定义
            wire [9:0]idm_in_rwa;
            wire idm_in_we,idm_in_re;
            wire [31:0] idm_in_wd,idm_out_rd;
        
        //指令寄存器,数据寄存器 模块变量定义
            wire[31:0]IR_in_d,DR_in_d,IR_out_d,DR_out_d;
            wire IR_in_e;
        //寄存器组 模块变量定义
             wire [4:0]rf_in_ra1,rf_in_ra2;
             wire rf_in_wre;
             wire [4:0]rf_in_wa;
             wire [31:0]rf_in_wd;
             wire[31:0]rf_out_rd1,rf_out_rd2;
         
         //寄存器组输出的寄存器 模块变量定义
             wire[31:0] RA_in_d,RB_in_d,RA_out_d,RB_out_d;
         //符号扩展器 模块变量定义
             wire se_in_sign;
             wire [31:0]se_out_data;
         
         //ALU多功能运算器 模块变量定义
             wire[31:0] alu_in_a;
             reg [31:0]alu_in_b;
             wire [3:0]alu_in_contr;
             wire alu_out_equ;
             wire[31:0] alu_out_rl,alu_out_rh;
         
         //运算结果寄存器 模块变量定义
             wire [31:0]RR_in_d,RR_out_d;
             
         //控制器 模块变量定义
             wire [5:0]Op;wire[5:0]Func;
             wire Bne,Beq,MemRead, MemWrite,RegWrite, PcWrite,IrWrite,RegDst,MemToReg,AluSrcA,PCsrc,lorD; 
             wire [1:0]AluSrcB;
             wire[3:0]ALU_OP,mini_address;
     
     
     //*******************************************loginc Implementation（程序逻辑实现）***********************************************//
        //$$$$$$$$$$$$$$$（PC寄存器  模块调用）$$$$$$$$$$$$$$$$$$//  
             assign PC_in_e=PcWrite|(Beq&alu_out_equ)|(Bne&~alu_out_equ);
             assign PC_in_d=PCsrc?RR_out_d:alu_out_rl;
             Reg PC(sys_clk_in,sys_rst_n,PC_in_d,PC_in_e,PC_out_d); 
              //    dis_PCR DPCR(sys_clk_in,sys_rst_n,PC_in_d,PC_out_d);
              //    always@(*)
              //    $display($time,,"PC_in_e=%b",PC_in_e);
         //#################（PC寄存器 模块结束）#################// 
            
        
         //$$$$$$$$$$$$$$$（周期计数器 模块调用）$$$$$$$$$$$$$$$$$$//  
               assign tcr_in_stop=(mini_address==4'hd)?1'b1:1'b0;
               Counter_Reg T_CR(sys_clk_in,sys_rst_n,1'b1,1'b0,tcr_in_stop,tcr_out_d);
         //#################（ 模块结束）#################//
        
             
         //$$$$$$$$$$$$$$$（停机 模块调用）$$$$$$$$$$$$$$$$$$//
            //发生停机指令时候存储器输入地址每过1ms增加1
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
                      
              //停机后输出存储器中值
                     always@(posedge sys_clk_in,negedge sys_rst_n)
                        if(!sys_rst_n)
                            Led_Data<=32'h0;
                         else   if(tcr_in_stop)
                                    Led_Data<=idm_out_rd;
                                else
                                    Led_Data<=32'h0; 
         //#################（ 模块结束）#################//    
        
                          
         //$$$$$$$$$$$$$$$（指令数据存储器  模块调用）$$$$$$$$$$$$$$$$$$//
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
             //模块输入输出显示                           
//                    dis_IDM DIDM(
//                     sys_clk_in,sys_rst_n,
//                                     idm_in_rwa,
//                                     idm_in_wd,
//                                     idm_in_we,
//                                     idm_in_re,
//                                     idm_out_rd,
//                                     RB_out_d);        
         //#################（  模块结束）#################//
         
            
          //$$$$$$$$$$$$$$$（ 指令寄存器  模块调用）$$$$$$$$$$$$$$$$$$//
            assign IR_in_e=IrWrite;
            assign IR_in_d=idm_out_rd;
           
            Reg IR(sys_clk_in,sys_rst_n,IR_in_d,IR_in_e,IR_out_d);
            //模块输入输出显示 
//                  dis_Instruct DI(sys_clk_in,IR_out_d);       
          //#################（ 模块结束）#################//
          
          
            //$$$$$$$$$$$$$$$（ 数据寄存器  模块调用）$$$$$$$$$$$$$$$$$$// 
              assign DR_in_d=idm_out_rd;
              Reg DR(sys_clk_in,sys_rst_n,DR_in_d,R_in_e,DR_out_d);
              
             //模块输入输出显示 
//                    always@(*)
//                         $display($time,,"数据寄存器:DR_in_e=%b，DR_out_d=%h",R_in_e,DR_out_d);  
            //#################（ 模块结束）#################//
                     
            
             //$$$$$$$$$$$$$$$（ 寄存器组  模块调用）$$$$$$$$$$$$$$$$$$//  
                assign rf_in_ra1=IR_out_d[25:21];
                assign rf_in_ra2=IR_out_d[20:16];
                assign rf_in_wre=RegWrite;
                assign rf_in_wa=RegDst?IR_out_d[15:11]:IR_out_d[20:16];
                assign rf_in_wd=MemToReg?DR_out_d:RR_out_d;
      
                Reg_File RF(
                         sys_clk_in,sys_rst_n,
                         rf_in_ra1,//读出数据的地址
                         rf_in_ra2,//
                        
                         rf_in_wre,//写使能信号
                        
                        rf_in_wa,// 写入数据的地址
                        rf_in_wd,//写入数据
                        
                        rf_out_rd1,//读出寄存器组的数据
                        rf_out_rd2
                        );
               //模块输入输出显示 
//                    always@(*)
//                        $display($time,,"寄存器组:rf_in_ra1=%h，rf_in_ra2=%h，rf_in_wre=%h，rf_in_wa=%h",rf_in_ra1,rf_in_ra2,rf_in_wre,rf_in_wa);
//                    always@(*)
//                        $display($time,,"寄存器组:rf_out_rd1=%h， rf_out_rd2=%h，", rf_out_rd1,rf_out_rd2); 
            //#################（ 模块结束）#################//
                          
           
          //$$$$$$$$$$$$$$$（ A寄存器 模块调用）$$$$$$$$$$$$$$$$$$//
                assign RA_in_d=rf_out_rd1;
                Reg RA(sys_clk_in,sys_rst_n,RA_in_d,R_in_e,RA_out_d);
                
                //模块输入输出显示 
//                  always@(*)
//                        $display($time,,"A寄存器：RA_in_d=%h，RR_in_e=%h,RA_out_d=%h",RA_in_d,R_in_e,RA_out_d);   
         //#################（ 模块结束）#################//    
            
                    
         //$$$$$$$$$$$$$$$（ B寄存器 模块调用）$$$$$$$$$$$$$$$$$$// 
               assign RB_in_d=rf_out_rd2;
               
               Reg RB(sys_clk_in,sys_rst_n,RB_in_d,R_in_e,RB_out_d);
               //模块输入输出显示  
//                   always@(*)
//                        $display($time,,"B寄存器：RB_in_d=%h，RR_in_e=%h,RB_out_d=%h",RB_in_d,R_in_e,RB_out_d);  
        //#################（ 模块结束）#################//
        
             
        //$$$$$$$$$$$$$$$（ 符号扩展器 模块调用）$$$$$$$$$$$$$$$$$$//
             assign se_in_sign=IR_out_d[15];
             Sign_Extender SE(se_in_sign, se_out_data);   
        //#################（ 模块结束）#################// 
           
       
        //$$$$$$$$$$$$$$$（ALU 模块调用）$$$$$$$$$$$$$$$$$$//
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
                                
                                 alu_in_a,//参加运算的数A
                                 alu_in_b,//参加运算的数B
                                 alu_in_contr,//运算功能控制
                                
                                 alu_out_equ,
                                 alu_out_rl,//低字节
                                 alu_out_rh//高字节
                               );
          //模块输入输出显示  
//               always@(*)
//               begin
//                    $monitor($time,,"运算器: alu_in_a=%h，alu_in_b=%h， alu_in_contr=%h,alu_out_equ=%h", alu_in_a,alu_in_b, alu_in_contr,alu_out_equ);
//                    $monitor($time,,"运算器: alu_out_rl=%h，alu_out_rh=%h", alu_out_rl,alu_out_rh);
//                end    
        //#################（ 模块结束）#################//    
          
            
        
        //$$$$$$$$$$$$$$$（运算结果寄存器  模块调用）$$$$$$$$$$$$$$$$$$// 
             assign RR_in_d=alu_out_rl;
             Reg RR(sys_clk_in,sys_rst_n,RR_in_d,R_in_e,RR_out_d);
             
             //模块输入输出显示  
//              always@(*)
//                  $display($time,,"运算结果保存寄存器：RR_in_d=%h，RR_in_e=%h,RR_out_d=%h",RR_in_d,R_in_e,RR_out_d);  
        //#################（ 模块结束）#################//
            
        
        
        //$$$$$$$$$$$$$$$（控制器  模块调用）$$$$$$$$$$$$$$$$$$//
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
              //模块输入输出显示
//                 always@(*)
//                     begin
//                        $display($time,,"ALU_OP=%h",ALU_OP);
//                        $display($time,,"控制器：lorD=%b,PCsrc=%b,AluSrcA=%b,AluSrcB=%b, MemToReg=%b,RegDst=%b,IrWrite=%b,",lorD,PCsrc,AluSrcA,AluSrcB, MemToReg,RegDst,IrWrite);
//                        $display($time,," PcWrite=%b,RegWrite=%b,MemWrite=%b,MemRead=%b,Beq=%b,Bne=%b",PcWrite,RegWrite,MemWrite,MemRead,Beq,Bne);
//                     end   
        //#################（ 模块结束）#################//    
           
       
             
    
    
endmodule
