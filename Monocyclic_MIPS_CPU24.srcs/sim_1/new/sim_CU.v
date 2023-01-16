`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/24 08:52:45
// Design Name: 
// Module Name: sim_CU
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


module sim_CU(

    );
    
    reg rst_l;
    reg[5:0]Op,Func; //����������
    wire  MemToReg,MemWrite,Alu_SrcB,RegWrite,SysCall,SignedExt, RegDst,Beq,Bne,JR,JMP,JAL;
    wire [3:0]AluOP;
    //���ļ�
    initial
        begin
            rst_l=1'b0;
            #3 rst_l=1'b1;
        end
        
integer handle_r;
initial
begin
	//�򿪶��ļ�
		//r��ʽ���������ļ������ڻ�ȡ�����ź�����ֵ
		handle_r= $fopen("D:/Documents/Hardware_verlog/Sim_Data/Monocyclic_MIPS_CPU24/Sim_CU_Data.txt","r");
	//��ȡ�ļ�����
		while(!$feof(handle_r))
		begin
			#49  $fscanf(handle_r,"%d%d",Op,Func);//ÿ��49��ʱ�䵥λ����һ�μ����ź�
		end
	//�ر��ļ�
		$fclose(handle_r);
end

     Controller_Uint CU(
                        rst_l,
                        Op,
                        Func,
                        
                         AluOP,
                         MemToReg,
                         MemWrite,
                         Alu_SrcB,
                         RegWrite,
                         SysCall,
                        
                         SignedExt,
                         RegDst,
                         Beq,
                         Bne,
                         JR,
                         JMP,
                         JAL
                            );
endmodule
