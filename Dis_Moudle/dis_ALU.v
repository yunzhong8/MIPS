module dis_ALU(
input [31:0]alu_in_a,//参加运算的数A
input [31:0]alu_in_b,//参加运算的数B
input [3:0]alu_in_contr,//运算功能控制

input alu_out_equ,
input [31:0] alu_out_rl,//低字节
input [31:0] alu_out_rh,//高字节

input[31:0]ALU_IN_B
);
 always@(*)
   $strobe($time,,"ALU:ALU_IN_B=%h,alu_in_a=%h,alu_in_b=%h,alu_in_contr=%h,alu_out_equ=%h,alu_out_rl=%h,alu_out_rh=%h",ALU_IN_B,alu_in_a,alu_in_b,
alu_in_contr,alu_out_equ,alu_out_rl,alu_out_rh);

endmodule