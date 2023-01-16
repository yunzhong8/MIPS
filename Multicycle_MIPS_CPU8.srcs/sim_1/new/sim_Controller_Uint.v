`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/22 18:11:53
// Design Name: 
// Module Name: sim_Controller_Uint
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


module sim_Controller_Uint(

    );
 reg sys_clk_in;
 reg sys_rst_n;
 reg  [5:0]Op;
 reg [5:0]Func;
 
 wire  Bne, Beq, MemRead, MemWrite, RegWrite, PcWrite, IrWrite, RegDst, MemToReg, AluSrcA, PCsrc, lorD;
 wire [1:0]AluSrcB;
 wire[3:0]ALU_OP;wire[3:0]mini_address;
 reg sys_clk_in, sys_rst_n;
 reg sys_clk_in,sys_rst_n;
 
 wire [31:0]insturct;
initial
begin
    sys_clk_in=1'b1;
    sys_rst_n=1'b0;
    #3 sys_rst_n=1'b1;
end
//���ļ�
integer handle_r;
initial
begin
	//�򿪶��ļ�
		//r��ʽ���������ļ������ڻ�ȡ�����ź�����ֵ
		handle_r= $fopen("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt","r");
	    #0$fscanf(handle_r,"%h",insturct);//ÿ��49��ʱ�䵥λ����һ�μ����ź�
	    Func<=insturct[5:0];
		Op<=insturct[31:26];
	//��ȡ�ļ�����
		while(!$feof(handle_r))
		begin
			#100  $fscanf(handle_r,"%h",insturct);//ÿ��49��ʱ�䵥λ����һ�μ����ź�
			Func<=insturct[5:0];
		    Op<=insturct[31:26];
		end
	//�ر��ļ�
		$fclose(handle_r);
end

//д�ļ�
//integer handle_w;
//initial
//begin
//	//��д�ļ�
//		//w��ʽ����д����ļ�������д��ϵͳ���������ֵ
//		handle_w= $fopen("D:/Documents/Hardware_verlog/Sim_Data/Multicycle_MIPS_CPU8/sim_CU/sim_CU_Result.txt","w");
//		//�������ֵ��ʾ�ڿ���̨��
//		handle_w=handle_w|32'h0000_0001;
//	//�����ͷ
//		//$fdisplay(handle_w,"time  Bne\t Beq\t MemRead\tMemWrite\t RegWrite\t PcWrite\tIrWrite\t RegDst\tMemToReg\t AluSrcA\t PCsrc\t lorD;");
//		$fdisplay(handle_w,"time  AluSrcB\tALU_OP\tmini_address;");
//	//������ֵ���ļ���
////		$fmonitor(handle_w,$time,,"%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t,",Bne, Beq, MemRead, MemWrite, RegWrite, PcWrite, IrWrite, RegDst, MemToReg, AluSrcA, PCsrc, lorD);
////		$fmonitor(handle_w,$time,,"%h\t%h\t%h",AluSrcB,ALU_OP,mini_address);
//		$monitor($time,,"%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t,",Bne, Beq, MemRead, MemWrite, RegWrite, PcWrite, IrWrite, RegDst, MemToReg, AluSrcA, PCsrc, lorD);
//		$monitor($time,,"%h\t%h\t%h",AluSrcB,ALU_OP,mini_address);
//	//�ر��ļ�
//		$fclose(handle_w);
//end


always#5
sys_clk_in=~sys_clk_in;

    
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
endmodule
