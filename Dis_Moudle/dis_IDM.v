module dis_IDM(
input clk,
input rst_l,
input [9:0]idm_in_rwa,
input [31:0]idm_in_wd,
input idm_in_we,
input idm_in_re,
input RB_out_d,

input wire[31:0]idm_out_rd
    ); 
always@(*)
       begin
            $display($time,,"指令数据存储器：idm_in_rwa=%h,RB_out_d=%h,idm_in_wd=%h,idm_in_we=%h,idm_in_re=%h,",idm_in_rwa,RB_out_d,idm_in_wd,idm_in_we,idm_in_re);            
             $display($time,,"指令数据存储器： idm_out_rd=%h", idm_out_rd);    
       end
endmodule             