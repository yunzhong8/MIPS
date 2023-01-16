`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/23 22:24:02
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
`include"defines.v"

module CPU(
    input sys_clk_in,
    input sys_rst_n,
    input Go,
    output wire[31:0]LED_DATA
    //output PC
);

//���ж�·ѡ����������һ���Ĵ���
 //**********************************Define Inner Variable***********************************************//
    wire [31:0]PC;
    wire[31:0] PCR_in_d,PCR_out_d;
    wire PCR_in_e;
    reg [31:0]PCR_IN_D;
    wire [31:0]instruct;
    //ͣ�� 
    wire N_halt;
    wire [31:0]LDR_in_d,LDR_out_d;
    wire LDR_in_e;
    
    //ָ��洢��
     wire [9:0]ir_in_a;
     wire [31:0]ir_out_d;
    //������ 
    wire [5:0]Op,Func; //����������
    wire [`SignBus]sign;
    wire  MemToReg,MemWrite,Alu_SrcB,RegWrite,SysCall,SignedExt, RegDst,Beq,Bne,JR,JMP,JAL;
    wire  cuMemToReg,cuMemWrite,cuAlu_SrcB,cuRegWrite,cuSysCall,cuSignedExt, cuRegDst,cuBeq,cuBne,cuJR,cuJMP,cuJAL;
    wire [3:0]AluOP;
     wire [3:0]cuAluOP;
    //�Ĵ�����
    reg [4:0] RF_IN_WA;
    reg [31:0]RF_IN_WD;
    reg [31:0]ALU_IN_B;
    wire rf_in_wre;//�Ĵ������дʹ���źţ�1w��0r

    wire [4:0] rf_in_ra1,rf_in_ra2; //�Ĵ�����Ķ���ַ
    wire [31:0]rf_out_rd1,rf_out_rd2;//�Ĵ������������
   
    wire[4:0]rf_in_wa;//�Ĵ�����д���ַ
    wire[31:0]rf_in_wd;//�Ĵ�����д������
    
    //������ 
   wire [31:0]alu_in_a,alu_in_b;//���������������A,B
   wire [3:0]alu_in_contr;//�������Ŀ����ź�
   wire [4:0]alu_in_shamt;
   wire alu_out_equ;//��������ź�
   wire [31:0]alu_out_rl,alu_out_rh;//���������

    //���ݴ洢�� 
   wire dm_in_wre;//���ݴ洢�� ��д��ʹ���źţ�1w,0r
   wire [9:0] dm_in_rwa;//���ݴ洢�� �Ķ�д��ַ
   wire[31:0]dm_in_wd,dm_out_rd;//���ݴ洢�� ��д���ݣ�������
    
////////////////////////////////////////////////////////////////////////////////////////////////������չ��
   wire  se_in_sign;
   wire [31:0]se_out_data;

    
 //*******************************************loginc Implementation *****************************************//
 /////////////////////////////////////////////////////////////////////////////////////////////////PC������
    always@(*)
        case({JR,JMP,(Beq&alu_out_equ)|(Bne&~alu_out_equ)})
            3'b000:PCR_IN_D<=PC+ 32'h4; 
            3'b001:PCR_IN_D<={se_out_data[13:0],instruct[15:0],2'h0}+PC+32'h4;
            3'b010:PCR_IN_D<={PC[31:28],instruct[25:0],2'h0}; 
            3'b100:PCR_IN_D<=rf_out_rd1;
        endcase
        
    assign PCR_in_d=PCR_IN_D;
    assign PCR_in_e=~N_halt|Go;
//    Reg PCR(sys_clk_in,sys_rst_n,PCR_in_d,PCR_in_e,PCR_out_d);
    dff u_pc(.clk(sys_clk_in), .rst_n(sys_rst_n), .en(PCR_in_e), .din(PCR_in_d), .dout(PCR_out_d));
    assign PC=PCR_out_d;
        
 ///////////////////////////////////////////////////////////////////////////////////////////////////ͣ��
   assign N_halt=SysCall&~(32'h22^~rf_out_rd1);//��ͬ������ȱȽ�
   assign LDR_in_d=rf_out_rd2;
   assign LDR_in_e=(32'h22^~rf_out_rd1)&SysCall;
   
   dff LDR(.clk(sys_clk_in), .rst_n(sys_rst_n), .en(LDR_in_e), .din(LDR_in_d), .dout(LDR_out_d));
//   Reg LDR(sys_clk_in,sys_rst_n,LDR_in_d,LDR_in_e,LDR_out_d);
   assign LED_DATA=LDR_out_d;
      
 /////////////////////////////////////////////////////////////////////////////////////////////�� ָ��洢�� ȡ��ָ��
    assign ir_in_a=PC[11:2];//��ȡ ָ��洢�� ��ַ
//    Instruct_Memory IR(sys_rst_n,ir_in_a, instruct);//ȡָ��
    im u_im(
    .addr   (ir_in_a),      // addr [5 :0]
    .dout   (instruct             )       // inst [31:0]
);
    //assign instruct=ir_out_d;//��ָ������

 ///////////////////////////////////////////////////////////////////////////////////////////////�Ĵ�����

    assign rf_in_ra1=SysCall?5'h02:instruct[25:21];//��ȡ �Ĵ������ �����ַ1
    assign rf_in_ra2=SysCall?5'h04:instruct[20:16];//��ȡ �Ĵ������ �����ַ2
    assign rf_in_wre=RegWrite;//��ȡ �Ĵ������ ��дʹ���ź�
    
    always @(*)//��ȡд���ַ
    	case({JAL,RegDst})
            2'b00:RF_IN_WA<=instruct[20:16];
            2'b01:RF_IN_WA<=instruct[15:11];
            default:RF_IN_WA<=5'h1f;
    	endcase
    assign rf_in_wa=RF_IN_WA;

    always @(*)//��ȡд������
    	case({JAL,MemToReg})
    	2'b00:RF_IN_WD<=alu_out_rl;
    	2'b01:RF_IN_WD<=dm_out_rd;
    	default:RF_IN_WD<=PC+32'h4;
    	endcase
    assign rf_in_wd=RF_IN_WD;//��ȡд������
    
regfile u_regfile(
    .clk        (sys_clk_in        ),
    .we         ( rf_in_wre     ),
    .raddr1     (rf_in_ra1),
    .raddr2     (rf_in_ra2),
    .waddr      (rf_in_wa  ),
    .wdata      (rf_in_wd  ),
    .rdata1     (rf_out_rd1   ),
    .rdata2     (rf_out_rd2   )
);

     
////////////////////////////////////////////////////////////////////////////////////������չ��
    assign se_in_sign=instruct[15];
    
    Sign_Extender SE(se_in_sign,se_out_data);

 /////////////////////////////////////////////////////////////////////////////////////ALU
    assign alu_in_a=rf_out_rd1;//��ȡALU���������A
    assign alu_in_contr= AluOP;//��ȡALU�����ź�
    assign alu_in_shamt=instruct[10:6];
    
    always@(*)//��ȡALU���������B
     	if(Alu_SrcB)
		ALU_IN_B=SignedExt?{se_out_data[15:0],instruct[15:0]}:{16'h0,instruct[15:0]};
	else
		ALU_IN_B=rf_out_rd2;
    assign alu_in_b=ALU_IN_B;
   
  
alu u_alu(
    .x          (alu_in_a     ),
    .y          (alu_in_b      ),
    .shamt      (alu_in_shamt    ),
    .aluop      (alu_in_contr      ),
    .r          (alu_out_rl     )
);
assign alu_out_equ=alu_out_rl[0];



/////////////////////////////////////////////////////////////////////////////////////���ݴ洢��
    assign dm_in_wre=MemWrite;//��ȡ���ݴ洢��ʹ���źţ�W1,R0
    assign dm_in_rwa=alu_out_rl[11:2];
    assign dm_in_wd=rf_out_rd2;
  

dm u_dm(
    .clk        (sys_clk_in        ),
    .re         (dm_in_wre     ),
    .we         (mem_re     ),
    .addr       (dm_in_rwa),
    .wdata      (dm_in_wd     ),
    .rdata      (dm_out_rd   )
);
 //////////////////////////////////////////////////////////////////////////////������
    assign Op=instruct[31:26];
    assign Func=instruct[5:0];
    Module_cu CU(sys_rst_n, 
                  Op,Func,
                  AluOP,sign    );
    
   
    assign {Alu_SrcB,SignedExt}=sign[18:17];
    assign MemWrite =sign[15];
    assign {RegWrite,RegDst,MemToReg}=sign[11:9];
    assign {Beq,Bne}=sign[7:6];
    assign {JR,JMP,JAL,SysCall}=sign[3:0];
        
                      
endmodule

