module dis_DM(
input dm_in_wre, //��ǰ����1��Ч�����0��Ч
input wire [9:0] dm_in_rwa,
input wire [31:0] dm_in_wd,
input wire[31:0] dm_out_rd
);

always@(*)
 $strobe($time,,"�洢����m_in_wre=%h,dm_in_rwa=%h,dm_in_wd=%h,dm_out_rd=%h",
                 dm_in_wre,dm_in_rwa,dm_in_wd,dm_out_rd);//��������
endmodule