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
    //���ļ�
integer handle_r;
initial
begin
	//�򿪶��ļ�
		//r��ʽ���������ļ������ڻ�ȡ�����ź�����ֵ
		handle_r= $fopen("D:/Documents/Hardware_verlog/Sim_Data/Multicycle_MIPS_CPU8/sim_AS/sim_AS_data.txt","r");
	//��ȡ�ļ�����
		while(!$feof(handle_r))
		begin
			#49  $fscanf(handle_r,"%b",as_in_instr);//ÿ��49��ʱ�䵥λ����һ�μ����ź�
		end
	//�ر��ļ�
		$fclose(handle_r);
end
    Address_Shift AS(as_in_instr,as_out_address);
endmodule
