`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/11 12:31:08
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
    input sys_rst_n
);
    //Define Inner Variable
    reg [31:0]PC;
    //指令存储器
    wire [31:0]instruct;

    //控制器 
    wire [5:0]Op,Func; //控制器输入
    wire  Halt,MemtoReg,MemWrite,Beq,Bne,AluOP,AluSrcB,RegWrite,RegDst; //控制器输出

    //寄存器组
    wire [4:0]R1_A,R2_A,RF_WE; //寄存器组的输入
    reg [4:0]W_A,W_D;
    wire [31:0]R1,R2; //寄存器组输出

    //运算器 
    wire [31:0]A;
    reg[31:0]B;
    
    wire [3:0]AluOP;
    
    wire equ;wire [31:0]ALUR1,ALUR2;
    //数据存储器 
    wire [9:0]DM_DA ;
    wire [31:0]DM_RD,DM_WD;
    
    //符号扩展器

    //loginc Implementation 
    //PC产生器
    
    always @(posedge sys_clk_in,negedge sys_rst_n)
    if(! sys_rst_n)//复位
        PC<=32'h0000_0000;
    else    if(( Beq&&equ)||(Bne&&!equ)) //跳转时PC变化
        PC<=PC+4+{16'h0,instruct[15:0]}<<2;
    else //正常PC变化
        PC<=PC+4;

    //从指令寄存器取出指令
    Instruct_Memory IR(sys_rst_n,PC[11:2],instruct);

    //指令拆解,寄存器组
    assign Op=instruct[31:26];
    assign Func=instruct[5:0];
    assign R1_A=instruct[25:21];
    assign R2_A=instruct[20:16];
    
    always @(instruct,RegDst)//确定 寄存器组 写入数据对应的地址
    if(RegDst)
        W_A<=instruct[15:11];
    else
        W_A<=instruct[20:16];
        
    assign  RF_WE=RegWrite ;
    RegFile RF(sys_clk_in,sys_rst_n,R1_A,R2_A,RF_WE,W_A,W_D,R1,R2);

    //ALU
    assign A=R1;//确定ALU口的输入值
    
    always@(*)//确定加法器B端口输入数据
    if(AluSrcB)
    B<=R2;
    else    if(instruct[15]==1'b1)
    B<={16'hffff,instruct[15:0]};//符号扩展
    else
    B<={16'h0,instruct[15:0]};//符号扩展
    
    
    ALU alu(A,B,AluOP,equ,ALUR1,ALUR2);

    //数据存储器
    assign DM_DA=ALUR1[11:2];//数据存储器的 读入写入地址
    assign DM_WD=R2;//数据存储器 写入数据的值
    //确定寄存器组写入数据的值
    always@*
    if(MemtoReg)
    W_D<=DM_RD;
    else
    W_D<=ALUR1;

    
    Data_Memory DM(sys_clk_in,sys_rst_n,MemWrite,DM_DA,DM_WD,DM_RD);
    
    

    //控制器
    controller CU(
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




endmodule
