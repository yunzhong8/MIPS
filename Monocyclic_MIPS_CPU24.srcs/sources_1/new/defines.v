`define OpLen 6
`define OpBus `OpLen-1:0
`define FuncLen 6
`define FuncBus `FuncLen-1:0

`define SignLen 20
`define SignBus `SignLen-1:0

`define StateLen 4
`define StateBus `StateLen-1:0

`define AluOpLen 4
`define AluOpBus  `AluOpLen-1：0


`define AluOpSll 4'h0
`define AluOpSrl 4'h1
`define AluOpSra 4'h2

`define AluOpAdd 4'h5
`define AluOpSub 4'h6

`define AluOpAnd 4'h7
`define AluOpOr 4'h8
`define AluOpXor 4'h9
`define AluOpNor 4'ha

`define AluOpSlt 4'hb
`define AluOpSltu 4'hc
`define AluOpLui 4'hd
`define AluOpEqu 4'he


//------------ 指令译码 -------------

//------- R型
`define Rtype           6'b00_0000
//移位运算
`define FuncSll         6'b00_0000       // 1
`define FuncSrl         6'b00_0010       // 2
`define FuncSra         6'b00_0011       // 3

`define FuncSllv        6'b00_0100       // 4
`define FuncSrlv        6'b00_0110       // 5
`define FuncSrav        6'b00_0111       // 6
//算术运算
`define FuncAdd         6'b10_0000       // 7
`define FuncAddu        6'b10_0001       // 8
`define FuncSub         6'b10_0010       // 9
`define FuncSubu        6'b10_0011       // 10

`define FuncSlt         6'b10_1010       // 11
`define FuncSltu        6'b10_1011       // 12
//R逻辑运算
`define FuncAnd         6'b10_0100       // 13
`define FuncOr          6'b10_0101       // 14
`define FuncXor         6'b10_0110       // 15
`define FuncNor         6'b10_0111       // 16

`define FuncJr          6'b00_1000       // 17

`define FuncSyscall     6'b00_1100       // 18

//-------- I型
`define OpAddi        6'b00_1000       // 19
`define OpAddiu       6'b00_1001       // 20

`define OpSlti        6'b00_1010       // 21
`define OpSltiu       6'b00_1011       // 22

`define OpAndi        6'b00_1100       // 23
`define OpOri         6'b00_1101       // 24
`define OpXori        6'b00_1110       // 25

`define OpLui         6'b00_1111       // 26

`define OpLw          6'b10_0011       // 27
`define OpSw          6'b10_1011       // 28

`define OpBeq         6'b00_0100       // 29
`define OpBne         6'b00_0101       // 30

//-------- J型
`define OpJ           6'b00_0010       // 31
`define OpJal         6'b00_0011       // 32







