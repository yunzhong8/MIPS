module dis_RF(
input clk,
input rst_l,
input [4:0] rf_in_ra1,//�������ݵĵ�ַ
input [4:0] rf_in_ra2,//

input rf_in_wre,//дʹ���ź�

input [4:0]rf_in_wa,// д�����ݵĵ�ַ
input [31:0]rf_in_wd,//д������

output [31:0]rf_out_rd1,//�����Ĵ����������
output [31:0]rf_out_rd2,
input  [31:0]RF_IN_WD
);
always@(RF_IN_WD,rf_in_ra1,rf_in_ra2,rf_in_wre,rf_in_wa,rf_in_wd,rf_out_rd1,rf_out_rd2)
    if(!rst_l);
    else
        $display($time,,"�Ĵ����飺RF_IN_WD=%h��rf_in_ra1=%h,rf_in_ra2=%h,rf_in_wre=%h,rf_in_wa=%h,rf_in_wd=%h,rf_out_rd1=%h,rf_out_rd2=%h",
        RF_IN_WD,rf_in_ra1,rf_in_ra2,rf_in_wre,rf_in_wa,rf_in_wd,rf_out_rd1,rf_out_rd2);//��������
endmodule
 