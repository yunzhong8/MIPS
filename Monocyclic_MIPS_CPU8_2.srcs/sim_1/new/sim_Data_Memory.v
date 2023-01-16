`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/17 22:33:47
// Design Name: 
// Module Name: sim_Data_Memory
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


module sim_Data_Memory(

    );
    reg clk,rst_l,dm_in_wre;
    reg [9:0]dm_in_rwa;
    reg [31:0]dm_in_wd;
    wire [31:0]dm_out_rd;
    initial
        begin
            clk=1'b0;
            rst_l=1'b0;
            dm_in_wre=1'b1;//дʹ��
            dm_in_rwa=10'h0;//д��ַ
            dm_in_wd=32'h0;//д����
            
            #5 rst_l=1'b1;//��λ�ź���Ч
            repeat(15)
                begin
                    #3 dm_in_rwa=dm_in_rwa+4'h1;//д��ַ����
                       dm_in_wd=dm_in_wd+32'h1;//д����
                end
                
         #200
            dm_in_wre=1'b0;//��ʹ��
            dm_in_rwa=10'h0;//����ַ��λ
            repeat(15)
                begin
                    #3 dm_in_rwa=dm_in_rwa+4'h1;//����ַ����
                end
           
        end
    //ʱ���ź�
    always #1
        begin
            clk=~clk;
        end
    
     Data_Memory DM(
                     clk,
                     rst_l,
                    
                     dm_in_wre, //��ǰ����1��Ч�����0��Ч
                     dm_in_rwa,
                     dm_in_wd,
                     
                     dm_out_rd
                    );
endmodule
