 module dis_PCR(
 input clk,
 input rst_l,
input [31:0]pcr_in_pc,
input [31:0]pcr_out_pc
) ;

 always@(*)
     if(!rst_l)
     ;
     else
        begin
            //$strobe($time,," ************************本周期代输入PC=%h",pcr_in_pc);
            $strobe($time,," ************************本周期PC=%h",pcr_out_pc);
        end
endmodule