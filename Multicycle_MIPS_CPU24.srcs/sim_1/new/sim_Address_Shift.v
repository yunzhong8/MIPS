`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/22 19:30:52
// Design Name: 
// Module Name: sim_Address_Shift
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


module sim_Address_Shift(

    );
    reg  [6:0]as_in_instr;
    wire [3:0]as_out_address;
    //读文件
integer handle_r;
initial
begin
	//打开读文件
		//r方式，被读的文件，用于获取激励信号输入值
		handle_r= $fopen("D:/Documents/Hardware_verlog/Sim_Data/Multicycle_MIPS_CPU8/sim_AS/sim_AS_data.txt","r");
	//读取文件内容
		while(!$feof(handle_r))
		begin
			#49  $fscanf(handle_r,"%b",as_in_instr);//每个49个时间单位更新一次激励信号
		end
	//关闭文件
		$fclose(handle_r);
end
    Address_Shift AS(as_in_instr,as_out_address);
endmodule
