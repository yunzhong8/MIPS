module dis_SE(
 input  se_in_sign,
 input  [31:0] se_out_data
);

always@(*)
    $strobe($time,,"·ûºÅÀ©Õ¹Æ÷se_in_sign=%h,se_out_data=%h",
    se_in_sign,se_out_data);
endmodule