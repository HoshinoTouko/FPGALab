`define ALUOP_ADD 3'b000
`define ALUOP_SUB 3'b010
`define ALUOP_OR 3'b100
`define ALUOP_NOR 3'b001
`define ALUOP_AND 3'b011
`define ALUOP_SLT 3'b111

`define EXTOP_ZERO 2'b00
`define EXTOP_SIGNED 2'b01
`define EXTOP_INST 2'b10

`define CTRL_OP_RTYPE 6'b000000
`define CTRL_OP_ORI 6'b001101
`define CTRL_OP_LW 6'b100011
`define CTRL_OP_SW 6'b101011
`define CTRL_OP_BEQ 6'b000100
`define CTRL_OP_JAL 6'b000011
`define CTRL_OP_J   6'b000010


`define CTRL_FUNCT_ADDU 6'b100001
`define CTRL_FUNCT_ADD  6'b100000
`define CTRL_FUNCT_SUBU 6'b100011
`define CTRL_FUNCT_SUB  6'b100010
`define CTRL_FUNCT_NOR  6'b100111
`define CTRL_FUNCT_AND  6'b100100
`define CTRL_FUNCT_OR   6'b100101

`define CTRL_FUNCT_SLT  6'b101010	
`define CTRL_FUNCT_SLTU 6'b101011