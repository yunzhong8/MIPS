module dis_Instruct(
input clk,
input [31:0] id_in_d
);
 //*******************************************Define Inner Variable***********************************************//
wire [5:0]Op,Func;
 //*******************************************loginc Implementation***********************************************//
assign Op=id_in_d[31:26];
assign Func=id_in_d[5:0];

always @(*)
        begin
            $display($time,," ***********************指令:instruct=%h",id_in_d);
        end
    always @(id_in_d)
     if(Op==6'h0)
                    case(Func)
                        6'd0:$display($time,," ***********************周期指令为SLL***********************");
                        6'd3:$display($time,," ***********************周期指令为SRA");
                        6'd2:$display($time,," ***********************周期指令为SRL");
                        6'd32:$display($time,," ***********************周期指令为ADD");
                        6'd33:$display($time,," ***********************周期指令为ADDU");
                        6'd34:$display($time,," ***********************周期指令为SUB");
                        6'd36:$display($time,," ***********************周期指令为AND");
                        6'd37:$display($time,," ***********************周期指令为OR");
                        6'd39:$display($time,," ***********************周期指令为NOR");
                        6'd42:$display($time,," ***********************周期指令为SLT");
                        6'd43:$display($time,," ***********************周期指令为SLTU");
                        6'd8:$display($time,," ***********************周期指令为JR");
                        6'd12:$display($time,," ***********************周期指令为SYSCALL");
                                endcase
                else
                    case(Op)
                        6'd2:$display($time,," ***********************周期指令为J");
                        6'd3:$display($time,," ***********************周期指令为JAL");
                        6'd4:$display($time,," ***********************周期指令为BNQ");
                        6'd5:$display($time,," ***********************周期指令为BNEL");
                        6'd8:$display($time,," ***********************周期指令为ADDI");
                        6'd12:$display($time,," ***********************周期指令为ANDI");
                        6'd9:$display($time,," ***********************周期指令为ADDU");
                        6'd10:$display($time,," ***********************周期指令为SLTI");
                        6'd13:$display($time,," ***********************周期指令为ORI");
                        6'd35:$display($time,," ***********************周期指令为LW");
                        6'd43:$display($time,," ***********************周期指令为SW");
                    endcase
                    

endmodule