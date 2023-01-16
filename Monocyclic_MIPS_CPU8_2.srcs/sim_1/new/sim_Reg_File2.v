`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/18 02:43:47
// Design Name: 
// Module Name: sim_Reg_File2
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


module sim_Reg_File2(

    );
     reg clk,rst_l;
    reg [4:0] rf_in_ra1,rf_in_ra2;
    reg rf_in_wre;
    reg [4:0]rf_in_wa;
    reg [31:0]rf_in_wd;
    wire [31:0]rf_out_rd1,rf_out_rd2;
    
    initial
    begin
        clk=1'b0;
        rst_l=1'b0;
        rf_in_wd=32'h0;//д���ݳ�ʼ��
        rf_in_wa=4'h0;//д��ַ��ʼ��
        
        rf_in_ra1=5'd0;//����ַ��ʼ�� 1
        rf_in_ra2=5'd0;//����ַ��ʼ�� 2 
        
        #5 rst_l=1'b1;//��λ�ź���Ч
        rf_in_wre=1'b0;//��ʹ��
        repeat(8'd25)
            begin
              #3 rf_in_ra1=rf_in_ra1+5'd1;//�����ַ
                 rf_in_ra2=rf_in_ra2+5'd1;
            end
     end
    always #1 
    begin
    clk=~clk;
    end
    
    Reg_File RF( clk, rst_l,
    rf_in_ra1,//�������ݵĵ�ַ
    rf_in_ra2,//

     rf_in_wre,//дʹ���ź�

    rf_in_wa,// д�����ݵĵ�ַ
    rf_in_wd,//д������

    rf_out_rd1,//�����Ĵ����������
    rf_out_rd2
    );
endmodule
