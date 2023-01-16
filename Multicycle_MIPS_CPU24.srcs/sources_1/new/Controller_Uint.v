`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 18:53:12
// Design Name: 
// Module Name: Controller_Uint
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


module Controller_Uint(
input clk,
input rst_l,
input  [5:0]Op,
input [5:0]Func,

output Bne,
output Beq,
output MemRead,
output MemWrite,
output RegWrite,
output PcWrite,
output IrWrite,
output RegDst,
output MemToReg,
output[1:0] AluSrcB,
output AluSrcA,
output PCsrc,
output lorD,
output reg[3:0]ALU_OP,
output JMP,
output JR,
output JAL,
output Syscall,
output SignedExt,
output [3:0]mini_address



    );
    parameter MC_LEN=5'd31;
    //������������ڰ�as_in_instrд��Ϊad_in_instr����������� �����˰��� 
    //��ַת����Ҳд���ˣ�ԭ���������������Ӧ��ϵ���� 
//*******************************************Define Inner Variable�������ڲ�������***********************************************//
    //ָ��ʶ��ģ��������� 
    reg [4:0]CU_address;//ָ������洢���ĵ�ַ
    reg[11:0]CU_I_Mem[24:0] ;//�洢ÿ��ָ���Ӧ��״̬���еĵ�ַ
    reg[4:0]CU_Alu_Mem[24:0] ;//�洢ÿ��ָ���Ӧ�����������������ֵ
      
    //��ַת����
    wire [6:0]as_in_instr;//��ַת����������
    wire [5:0]as_out_address;//��ַת�Ƶ����
    
    //ָ����ƴ洢��
    reg [26:0]Addr_Mem[26:0];
    wire[4:0] next_addr;//ָ�����ַ
    reg [4:0]ad_ra;//���ƴ洢���ķ��ʵ�ַ
    wire [26:0]Instruct;
    
    //��ַ�����ź� 
    wire P;
    
    //ALU�����ź�
    wire [1:0]ALU_Control;
    ////////////////////////////////////logic implementation
//    always@(*)
//        $monitor($time,,"����������ģ�Op=%h,Func=%h",Op,Func);
//*******************************************loginc Implementation�������߼�ʵ�֣�***********************************************//

 //$$$$$$$$$$$$$$$�� ָ��ʶ�� ģ�飩$$$$$$$$$$$$$$$$$$// 
  //ʶ��Lָ�������ָ��ָ������
   always @(*)
    if(!rst_l)
        begin
            $readmemb("D:/Documents/Hardware_verlog/Source_Data/Multicycle_MIPS_CPU24/CU_Addr_Data.txt",CU_I_Mem,1);
            $readmemh("D:/Documents/Hardware_verlog/Source_Data/Multicycle_MIPS_CPU24/CU_ALU_Data.txt",CU_Alu_Mem,1);
//            repeat(24)
//                    begin
//                     $display($time,,"CU_I_Mem[%d]=%h,CU_Alu_Mem[%d]=%h",i,CU_I_Mem[i],i,CU_Alu_Mem[i]);
//                     i=i+5'h1;
//                     end 
      end
        
    else    if(Op==6'h0)
                    case(Func)
                        6'd0:CU_address<=5'd1;//SLL
                        6'd3:CU_address<=5'd2;//SRA
                        6'd2:CU_address<=5'd3;//SRL
                        6'd32:CU_address<=5'd4;//ADD
                        6'd33:CU_address<=5'd5;//ADDU
                        6'd34:CU_address<=5'd6;//SUB
                        6'd36:CU_address<=5'd7;//AND
                        6'd37:CU_address<=5'd8;//OR 
                        6'd39:CU_address<=5'd9;//NOR
                        6'd42:CU_address<=5'd10;//SLT
                        6'd43:CU_address<=5'd11;//SLTU
                        6'd8:CU_address<=5'd12;//JR
                        6'd12:CU_address<=5'd13;//SYSCALL
                      endcase
                else
                    case(Op)
                        6'd2:CU_address<=5'd14;//J
                        6'd3:CU_address<=5'd15;//JAL 
                        6'd4:CU_address<=5'd16;//BEQ 
                        6'd5:CU_address<=5'd17;//BNE 
                        6'd8:CU_address<=5'd18;//ADDI 
                        6'd12:CU_address<=5'd19;//ANDI
                        6'd9:CU_address<=5'd20;//ADDIU
                        6'd10:CU_address<=5'd21;//SLTI
                        6'd13:CU_address<=5'd22;//ORI
                        6'd35:CU_address<=5'd23;//LW
                        6'd43:CU_address<=5'd24;//SW
                    endcase
    //#################�� ģ�������#################//  
  
    
  
    //$$$$$$$$$$$$$$$�� ��ַת����  ģ�飩$$$$$$$$$$$$$$$$$$//
        //ģ�����룺
            assign as_in_instr =CU_I_Mem[CU_address];
        //ģ����ã�
            assign as_out_address=as_in_instr;
        //ģ�����������ʾ��     
//            always @(ADD,SLT,SysCall,ADDI,LW,SW,BEQ,BNE,SysCall)
//            begin
//                $display($time,,"��ǰ״̬��Ӧ��ָ�RType=%h,ADDI=%h,LW=%h,SW=%h,BEQ=%h,BNE=%h,SysCall=%h",(ADD|SLT)&~SysCall,ADDI,LW,SW,BEQ,BNE,SysCall);
//                $display($time,,"��ַת���������룺",as_in_instr);
//            end
         
//            always@(*)
//                 $display($time,,"����ָ�����������Ӧָ��΢��ַ��CU_address=%h,as_out_address=%h",CU_address,as_out_address); 
  
	//#################�� ģ�������#################//  
    
    
    
    //$$$$$$$$$$$$$$$�� �źŴ洢�� ģ�飩$$$$$$$$$$$$$$$$$$// 
        reg [3:0]i=4'h0;
        always@(posedge clk,negedge rst_l)
            if(!rst_l)//��ʼ���źŴ洢����ַΪ0
                begin
                $readmemh("D:/Documents/Hardware_verlog/Source_Data/Multicycle_MIPS_CPU24/CU_Sign_Data.txt",Addr_Mem);
                ad_ra<=4'h0;
                i<=4'h0;
//                $display("��ʼ��΢����洢���ڱ���ָ��ֵ");
//                repeat(16)
//                    begin
//                        $display("Addr_Mem[%d]=%h",i,Addr_Mem[i]);
//                         i=i+4'h1;
//                    end
                end
            else    if(P)//PΪ1,Ϊ��ָ��ȡ����ָ���Ӧ���źŴ洢����ַ
                     ad_ra<=as_out_address;
                else//PΪ0ʱ���źŴ洢����ַΪָ����ַ
                     ad_ra<=next_addr;
	//#################�� ģ�������#################//  
   
   
    //$$$$$$$$$$$$$$$�� CU�����źŲ��� ģ�飩$$$$$$$$$$$$$$$$$$// 
    
         assign Instruct=Addr_Mem[ad_ra];//��ȡָ�� 
//always@ (*)
//    case(Instruct)
//         32'h00046401:$display($time,,"��ǰ״̬��ȡָ��");
//         32'h00060020:$display($time,,"��ǰ״̬����ָ��");
//         MC_LEN'h004c0003:$display($time,,"��ǰ״̬��LW1");
//         MC_LEN'h00200404:$display($time,,"��ǰ״̬��LW2");
//         MC_LEN'h00011000:$display($time,,"��ǰ״̬��LW3");
//         MC_LEN'h004c0006:$display($time,,"��ǰ״̬��SW1");
//         MC_LEN'h00200800:$display($time,,"��ǰ״̬��SW2");
//         MC_LEN'h00080088:$display($time,,"��ǰ״̬��R1");
//         MC_LEN'h00009000:$display($time,,"��ǰ״̬��BEQ");
//         MC_LEN'h00180240:$display($time,,"��ǰ״̬��BNE");
//         MC_LEN'h00180140:$display($time,,"��ǰ״̬��ADDI1");
//         MC_LEN'h004c008c:$display($time,,"��ǰ״̬��ADD2");
//         MC_LEN'h00001000:$display($time,,"��ǰ״̬��SYSCALL");
//         MC_LEN'h00800000:$display($time,,"��ǰ״̬��ANDI1");
//         MC_LEN'h000c008f:$display($time,,"��ǰ״̬��ANDI2");
//         MC_LEN'h00001000:$display($time,,"��ǰ״̬��ADDIU1");
//         MC_LEN'h004c0091:$display($time,,"��ǰ״̬��ADDIU1");
//         MC_LEN'h00001000:$display($time,,"��ǰ״̬��ADDIU1");
//         MC_LEN'h004c0093:$display($time,,"��ǰ״̬��SLTI1");
//        MC_LEN'h00001000:$display($time,,"��ǰ״̬��SLTI2");
//        MC_LEN'h000c0095:$display($time,,"��ǰ״̬��ORI1");
//        MC_LEN'h00001000:$display($time,,"��ǰ״̬��ORI2");
//        MC_LEN'h04000000:$display($time,,"��ǰ״̬��JR");
//        MC_LEN'h02000000:$display($time,,"��ǰ״̬��J");
//        MC_LEN'h02020019:$display($time,,"��ǰ״̬��JAL1");
//        MC_LEN'h04001000:$display($time,,"��ǰ״̬��JAL2");
//     endcase


//    always@ (*)
//        case(Instruct)
//             32'h00026401:$display($time,,"��ǰ״̬��ȡָ��");
//             32'h00060020:$display($time,,"��ǰ״̬����ָ��");
//             32'h004c0003:$display($time,,"��ǰ״̬��LW1");
//             32'h00200404:$display($time,,"��ǰ״̬��LW2");
//             32'h00011000:$display($time,,"��ǰ״̬��LW3");
//             32'h004c0006:$display($time,,"��ǰ״̬��SW1");
//             32'h00200800:$display($time,,"��ǰ״̬��SW2");
//             32'h00080088:$display($time,,"��ǰ״̬��R1");
//             32'h00009000:$display($time,,"��ǰ״̬��R2");
//             32'h00180240:$display($time,,"��ǰ״̬��BEQ");
//             32'h00180140:$display($time,,"��ǰ״̬��BNE");
//             32'h004c008c:$display($time,,"��ǰ״̬��ADDI1");
//             32'h00001000:$display($time,,"��ǰ״̬��ADDI2");
//             32'h00800000:$display($time,,"��ǰ״̬��SYSCALL");
//             32'h000c008f:$display($time,,"��ǰ״̬��ANDI1");
//             32'h00001000:$display($time,,"��ǰ״̬��ANDI2");
//             32'h004c0091:$display($time,,"��ǰ״̬��ADDIU1");
//             32'h00001000:$display($time,,"��ǰ״̬��ADDIU2");
//             32'h004c0093:$display($time,,"��ǰ״̬��SLTI1");
//            32'h00001000:$display($time,,"��ǰ״̬��SLTI2");
//            32'h000c0095:$display($time,,"��ǰ״̬��ORI1");
//            32'h00001000:$display($time,,"��ǰ״̬��ORI2");
//            32'h04002000:$display($time,,"��ǰ״̬��JR");
//            32'h02002000:$display($time,,"��ǰ״̬��J");
//            32'h02022019:$display($time,,"��ǰ״̬��JAL1");
//            32'h01001000:$display($time,,"��ǰ״̬��JAL2");
//         endcase
        

         
        //��ָ����������ź�
        assign next_addr=Instruct[4:0];//ȡ����ַ
        assign mini_address=next_addr;

        assign P=Instruct[5];//ȡ����ַ�����ź� 
   
        assign ALU_Control=Instruct[7:6];//ȡ��ALU��������ź� 
   
        assign {JR,JMP,JAL,Syscall,SignedExt,lorD,PCsrc,AluSrcA,AluSrcB, MemToReg,RegDst,IrWrite,PcWrite,RegWrite,MemWrite,MemRead,Beq,Bne}=Instruct[26:8];//ȡ�������ź� 
       //ģ�����������ʾ��
//         always@(*)
//         begin
//              $monitor($time,,"΢�����źŴ洢�����η��ʵ�ַ��ad_ra=%h",ad_ra);
//            $monitor($time,,"ȡ����΢�����ź�ָ�Instruct=%h",Instruct);
//         end

//        always@(*)
//            $monitor($time,,"�µ�ַ��next_addr=%b",next_addr);

//      always@(*)
//            $monitor($time,,"P=%b",P);

//       always@(*)
//            $monitor($time,,"�������ڲ�����ǰ״̬���������źţ�ALU_Control=%b",ALU_Control);

//       always@(*)
//         begin
//            $monitor($time,,"�������ڲ�����ǰ״̬���źţ�lorD=%b,PCsrc=%b,AluSrcA=%b,AluSrcB=%b, MemToReg=%b,RegDst=%b,IrWrite=%b,",Instruct[20],Instruct[19],Instruct[18],Instruct[17:16],Instruct[15],Instruct[14],Instruct[13]);
//            $monitor($time,," �������ڲ���PcWrite=%b,RegWrite=%b,MemWrite=%b,MemRead=%b,Beq=%b,Bne=%b",Instruct[12],Instruct[11],Instruct[10],Instruct[9],Instruct[8],Instruct[7]);
//            end
	//#################�� ģ�������#################//  
 
 
 
 
  //$$$$$$$$$$$$$$$�� ALU�����źŲ���  ģ�飩$$$$$$$$$$$$$$$$$$// 
        always@(*)
            case(ALU_Control)
                2'd0: ALU_OP=4'h5;
                2'd1: ALU_OP=4'h6;
                2'd2: ALU_OP=CU_Alu_Mem[CU_address];
                default: ALU_OP=4'h5;
            endcase
	//#################�� ģ�������#################// 













    
    
    
    
    
    
endmodule
