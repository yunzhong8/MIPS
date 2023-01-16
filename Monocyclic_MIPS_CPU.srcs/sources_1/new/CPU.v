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
    //ָ��洢��
    wire [31:0]instruct;

    //������ 
    wire [5:0]Op,Func; //����������
    wire  Halt,MemtoReg,MemWrite,Beq,Bne,AluOP,AluSrcB,RegWrite,RegDst; //���������

    //�Ĵ�����
    wire [4:0]R1_A,R2_A,RF_WE; //�Ĵ����������
    reg [4:0]W_A,W_D;
    wire [31:0]R1,R2; //�Ĵ��������

    //������ 
    wire [31:0]A;
    reg[31:0]B;
    
    wire [3:0]AluOP;
    
    wire equ;wire [31:0]ALUR1,ALUR2;
    //���ݴ洢�� 
    wire [9:0]DM_DA ;
    wire [31:0]DM_RD,DM_WD;
    
    //������չ��

    //loginc Implementation 
    //PC������
    
    always @(posedge sys_clk_in,negedge sys_rst_n)
    if(! sys_rst_n)//��λ
        PC<=32'h0000_0000;
    else    if(( Beq&&equ)||(Bne&&!equ)) //��תʱPC�仯
        PC<=PC+4+{16'h0,instruct[15:0]}<<2;
    else //����PC�仯
        PC<=PC+4;

    //��ָ��Ĵ���ȡ��ָ��
    Instruct_Memory IR(sys_rst_n,PC[11:2],instruct);

    //ָ����,�Ĵ�����
    assign Op=instruct[31:26];
    assign Func=instruct[5:0];
    assign R1_A=instruct[25:21];
    assign R2_A=instruct[20:16];
    
    always @(instruct,RegDst)//ȷ�� �Ĵ����� д�����ݶ�Ӧ�ĵ�ַ
    if(RegDst)
        W_A<=instruct[15:11];
    else
        W_A<=instruct[20:16];
        
    assign  RF_WE=RegWrite ;
    RegFile RF(sys_clk_in,sys_rst_n,R1_A,R2_A,RF_WE,W_A,W_D,R1,R2);

    //ALU
    assign A=R1;//ȷ��ALU�ڵ�����ֵ
    
    always@(*)//ȷ���ӷ���B�˿���������
    if(AluSrcB)
    B<=R2;
    else    if(instruct[15]==1'b1)
    B<={16'hffff,instruct[15:0]};//������չ
    else
    B<={16'h0,instruct[15:0]};//������չ
    
    
    ALU alu(A,B,AluOP,equ,ALUR1,ALUR2);

    //���ݴ洢��
    assign DM_DA=ALUR1[11:2];//���ݴ洢���� ����д���ַ
    assign DM_WD=R2;//���ݴ洢�� д�����ݵ�ֵ
    //ȷ���Ĵ�����д�����ݵ�ֵ
    always@*
    if(MemtoReg)
    W_D<=DM_RD;
    else
    W_D<=ALUR1;

    
    Data_Memory DM(sys_clk_in,sys_rst_n,MemWrite,DM_DA,DM_WD,DM_RD);
    
    

    //������
    controller CU(
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




endmodule
