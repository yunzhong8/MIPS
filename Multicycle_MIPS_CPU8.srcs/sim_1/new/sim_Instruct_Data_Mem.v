`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/22 17:38:06
// Design Name: 
// Module Name: sim_Instruct_Data_Mem
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


module sim_Instruct_Data_Mem(

    );
    reg sys_clk_in,sys_rst_n;
    reg [9:0]idm_in_rwa;
    reg [31:0]idm_in_wd;
    wire[31:0]idm_out_rd;
    reg idm_in_re,idm_in_we;
    initial 
    begin
    sys_clk_in=1'b1;
    sys_rst_n=1'b0;
    #4 
    sys_rst_n=1'b1;
    end
    
    always #5 
    sys_clk_in=~sys_clk_in;
    
     Instruct_Datat_Mem IDM(
                         sys_clk_in,sys_rst_n,
                         idm_in_rwa,
                         idm_in_wd,
                         idm_in_we,
                         idm_in_re,
                         idm_out_rd
                            );
endmodule
