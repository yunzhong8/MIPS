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
    reg[5:0]Op,Func; //控制器输入
    wire  MemToReg,MemWrite,Alu_SrcB,RegWrite,SysCall,SignedExt, RegDst,Beq,Bne,JR,JMP,JAL;
    wire [3:0]AluOP;
    //读文件
    initial
        begin
            rst_l=1'b0;
            #3 rst_l=1'b1;
        end
        
integer handle_r;
initial
begin
	//打开读文件
		//r方式，被读的文件，用于获取激励信号输入值
		handle_r= $fopen("D:/Documents/Hardware_verlog/Sim_Data/Monocyclic_MIPS_CPU24/Sim_CU_Data.txt","r");
	//读取文件内容
		while(!$feof(handle_r))
		begin
			#49  $fscanf(handle_r,"%d%d",Op,Func);//每个49个时间单位更新一次激励信号
		end
	//关闭文件
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
