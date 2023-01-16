`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/09 15:20:51
// Design Name: 
// Module Name: regfile
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


module regfile(
    input  wire         clk     ,
    input  wire         we      ,   // write enable, дʹ��
    input  wire [4 : 0] raddr1  ,   // read addr 1, ���˿�1
    input  wire [4 : 0] raddr2  ,   // read addr 2, ���˿�2
    input  wire [4 : 0] waddr   ,   // write addr, д�˿�
    input  wire [31: 0] wdata   ,   // write data, д����
    output wire [31: 0] rdata1  ,   // read data 1, ������1
    output wire [31: 0] rdata2      // read data 2, ������2
    );
    
    reg [31:0] reg_array [31:0];

    integer i;
    initial begin
        for(i=0;i<32;i=i+1) reg_array[i] = 0;   // ����ʹ�ã���Ϊ������δ��ʼ����reg��ֵΪX (��ʵ���ۺ�)
    end

    always @(posedge clk) begin
        if (we) reg_array[waddr] <= wdata;
    end

    assign rdata1 = (raddr1 == 5'b0)? 32'b0 : reg_array[raddr1];   
    assign rdata2 = (raddr2 == 5'b0)? 32'b0 : reg_array[raddr2];   
    
endmodule

