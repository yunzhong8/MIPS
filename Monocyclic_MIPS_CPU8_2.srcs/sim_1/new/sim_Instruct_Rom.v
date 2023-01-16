`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/30 17:00:19
// Design Name: 
// Module Name: sim_Instruct_Rom
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


module sim_Instruct_Rom(

    );
    reg clk;
    reg[9:0]irom_in_ra;
    wire [31:0]irom_out_d;
    initial
        begin
        clk=1'b1;
        #1 irom_in_ra=10'h0;
        #8 irom_in_ra=10'h2;
        
        
        end
        
        always #5 
            clk=~clk;
    Instruct_Rom IR(
    clk,
irom_in_ra,
irom_out_d

    );
endmodule
