module dis_LDR(
input LDR_in_d,
input LDR_in_e,
input LDR_out_d

);
  always@(*)
        $display($time,," LDR寄存器：LDR_in_d=%h,LDR_in_e=%h,LDR_out_d=%h",LDR_in_d,LDR_in_e,LDR_out_d);
endmodule