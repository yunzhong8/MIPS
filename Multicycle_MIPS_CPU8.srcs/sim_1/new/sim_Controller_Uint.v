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
//读文件
integer handle_r;
initial
begin
	//打开读文件
		//r方式，被读的文件，用于获取激励信号输入值
		handle_r= $fopen("D:/Documents/Hardware_verlog/MIPS_CPU/Complete_Routine_Test_Data/sort.txt","r");
	    #0$fscanf(handle_r,"%h",insturct);//每个49个时间单位更新一次激励信号
	    Func<=insturct[5:0];
		Op<=insturct[31:26];
	//读取文件内容
		while(!$feof(handle_r))
		begin
			#100  $fscanf(handle_r,"%h",insturct);//每个49个时间单位更新一次激励信号
			Func<=insturct[5:0];
		    Op<=insturct[31:26];
		end
	//关闭文件
		$fclose(handle_r);
end

//写文件
//integer handle_w;
//initial
//begin
//	//打开写文件
//		//w方式，被写入的文件，用于写入系统函数的输出值
//		handle_w= $fopen("D:/Documents/Hardware_verlog/Sim_Data/Multicycle_MIPS_CPU8/sim_CU/sim_CU_Result.txt","w");
//		//设置输出值显示在控制台上
//		handle_w=handle_w|32'h0000_0001;
//	//输出题头
//		//$fdisplay(handle_w,"time  Bne\t Beq\t MemRead\tMemWrite\t RegWrite\t PcWrite\tIrWrite\t RegDst\tMemToReg\t AluSrcA\t PCsrc\t lorD;");
//		$fdisplay(handle_w,"time  AluSrcB\tALU_OP\tmini_address;");
//	//将变量值到文件中
////		$fmonitor(handle_w,$time,,"%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t,",Bne, Beq, MemRead, MemWrite, RegWrite, PcWrite, IrWrite, RegDst, MemToReg, AluSrcA, PCsrc, lorD);
////		$fmonitor(handle_w,$time,,"%h\t%h\t%h",AluSrcB,ALU_OP,mini_address);
//		$monitor($time,,"%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t,",Bne, Beq, MemRead, MemWrite, RegWrite, PcWrite, IrWrite, RegDst, MemToReg, AluSrcA, PCsrc, lorD);
//		$monitor($time,,"%h\t%h\t%h",AluSrcB,ALU_OP,mini_address);
//	//关闭文件
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
