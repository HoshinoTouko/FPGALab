// R-Type
`define ADD 4'hb
`define SUB 4'h1
`define AND 4'h2
`define OR 4'h3
`define XOR 4'h4
`define NOR 4'h5
`define SLT 4'h6
`define SLTU 4'ha
`define SLL 4'h7
`define SRL 4'h8
`define SRA 4'h9
`define LU 4'hd
`define BNE 4'hc
`define BGTZ 4'h0
`define BLEZ 4'he
`define BLTZ 4'hf

`define Oadd 6'h20
`define Oaddu 6'h21
`define Osub 6'h22
`define Osubu 6'h23
`define Osll 6'h0
`define Osrl 6'h2
`define Osra 6'h3
`define Osllv 6'h4
`define Osrlv 6'h6
`define Osrav 6'h7
`define Oand 6'h24
`define Oor 6'h25
`define Oxor 6'h26
`define Onor 6'h27
`define Oslt 6'h2a
`define Osltu 6'h2b
`define Ojalr 6'h9
`define Ojr 6'h8

// I-Type
`define ADDI 4'h3
`define ADDIU 4'h4
`define ANDI 4'h5
`define ORI 4'h6
`define XORI 4'h7
`define LUI 4'h8
`define SLTI 4'h9
`define SLTIU 4'ha
