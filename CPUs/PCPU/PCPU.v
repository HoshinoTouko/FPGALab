`include "ctrl_encode_def.v"
module PCPU(
	input wire clk,
	input wire reset,
	input wire MIO_ready,
	input wire [31:0]inst_in,
	input wire [31:0]Data_in,

	output wire mem_w,
	output wire [31:0]PC_out,
	output wire [31:0]Addr_out,
	output wire [31:0]Data_out,
	output wire CPU_MIO,
	output wire INT
);
    wire [31:0] pc_in;
    wire [31:0] pc_out;
    wire [31:0] pc_add4;
    wire [31:0] pc_add4_id;
    wire [31:0] ins_id;
    wire [31:0] data_reg;
    wire [31:0] regout1;
    wire [31:0] regout2;
    wire [31:0] ext_out;
    wire [31:0] regout1_ex;
    wire [31:0] regout2_ex;
    wire [31:0] ext_out_ex;
    wire [4:0] rt_ex;
    wire [4:0] rs_ex;
    wire [4:0] rd_ex;
    wire [31:0] pc_add4_ex;
    wire [31:0] aludata2;
    wire [31:0] aluout;
    wire [4:0] wrreg_ex;
    wire [4:0] wrreg_wb;
    wire [31:0] pc_branch;
    wire [31:0] pc_branch2;
    wire [31:0] pc_branch3;
    wire [31:0] aluout_mem;
    wire [31:0] regout2_mem;
    wire [4:0] wrreg_mem;
    wire [31:0] memout;
    wire [31:0] memout_wb;
    wire [31:0] aluout_wb;
    wire [31:0] muxa_out;
    wire [31:0] muxb_out;
    wire [25:0] addr_jump;



    wire RegWrite;
    wire RegWrite_wb;
    wire [1:0]ExtOp;
    wire MemWrite;
    wire MemtoReg;
    wire RegDst;
    wire [2:0]ALUOP;
    wire ALUSrc;
    wire Branch;
    wire RegWrite_ex;
    wire [1:0]ExtOp_ex;
    wire MemWrite_ex;
    wire MemtoReg_ex;
    wire RegDst_ex;
    wire [2:0]ALUOP_ex;
    wire ALUSrc_ex;
    wire Branch_ex;
    wire Zero;
    wire MemWrite_mem;
    wire MemtoReg_mem;
    wire RegWrite_mem;



    wire MemtoReg_wb;
    wire [2:0] INS_ID;
    wire [2:0] INS_ID_ex;
    wire [2:0] INS_ID_mem;
    wire [2:0] INS_ID_wb;
    wire [1:0] ForwardA;
    wire [1:0] ForwardB;
    wire PcWrite;
    wire IF_IDWrite;
    wire Stall;
    wire JUMPSrc;
    wire JUMPSrc_ex;

    //PC
    PC pc(PcWrite,pc_out,reset,clk,pc_in);
    assign PC_out = pc_out;
    assign pc_add4 = pc_out+4;

    // ALU
    Alu alu(muxa_out,aludata2,ALUOP_ex,aluout,Zero);
    Alu alu_branch(pc_add4_ex,{ext_out_ex[29:0],2'b00},`ALUOP_ADD,pc_branch);

    //IF_ID
    IF_ID if_id(clk,IF_IDWrite,inst_in,pc_add4,pc_add4_id,ins_id);

    //GPR
    GPR gpr(clk,RegWrite_wb,wrreg_wb,ins_id[25:21],ins_id[20:16],data_reg,regout1,regout2);

    // Ext
    Ext ext(ins_id[15:0],ExtOp_ex,ext_out);

    //Ctrl
    Ctrl ctrl(clk,ins_id,Stall,MemWrite,MemtoReg,RegWrite,RegDst,ALUOP, ALUSrc, Branch,INS_ID,JUMPSrc,ExtOp);

    //ID_EX
    ID_EX id_ex(clk,regout1,regout2,ext_out,ins_id[25:21],ins_id[20:16],ins_id[15:11],pc_add4_id,MemWrite,MemtoReg,RegWrite,RegDst,ALUOP,ALUSrc,Branch,INS_ID,ins_id[25:0],JUMPSrc,ExtOp,ExtOp_ex,JUMPSrc_ex,addr_jump,MemWrite_ex,MemtoReg_ex,RegWrite_ex,RegDst_ex,ALUOP_ex,ALUSrc_ex,Branch_ex,INS_ID_ex,regout1_ex,regout2_ex,ext_out_ex,rs_ex,rt_ex,rd_ex,pc_add4_ex);

    // two_way_mux_32_bit
    two_way_mux_32_bit mux_alu(ALUSrc_ex,aludata2,muxb_out,ext_out_ex);
    two_way_mux_32_bit mux_regdst(RegDst_ex,wrreg_ex,rt_ex,rd_ex);
    two_way_mux_32_bit mux_branch(Zero&&Branch_ex,pc_branch2,pc_add4_ex,pc_branch);
    two_way_mux_32_bit mux_pc(Branch_ex,pc_branch3,pc_add4,pc_branch2);
    two_way_mux_32_bit mux_wb(MemtoReg_wb,data_reg,aluout_wb,memout_wb);
    two_way_mux_32_bit mux_JUMP(JUMPSrc_ex,pc_in,pc_branch3,{pc_add4_ex[31:28],addr_jump,2'b00});

    //EX_MEM
    EX_MEM ex_mem(clk,aluout,muxb_out,wrreg_ex,MemWrite_ex,MemtoReg_ex,RegWrite_ex,INS_ID_ex,INS_ID_mem,MemWrite_mem,MemtoReg_mem,RegWrite_mem,aluout_mem,regout2_mem,wrreg_mem);

    assign mem_w = MemWrite_mem;
    assign Addr_out = aluout_mem;
    assign Data_out = regout2_mem;
    assign memout = Data_in;

    // MEM_WB
    MEM_WB mem_wb(clk,memout,aluout_mem,wrreg_mem,MemtoReg_mem,RegWrite_mem,INS_ID_mem,INS_ID_wb,MemtoReg_wb,RegWrite_wb,memout_wb,aluout_wb,wrreg_wb);

    // Forward

    ForwardUnit forwardunit(rs_ex,rt_ex,wrreg_mem,wrreg_wb,INS_ID_mem,INS_ID_wb,ForwardA,ForwardB);

    // three_way_mux_32_bit
    three_way_mux_32_bit muxa(ForwardA,muxa_out,regout1_ex,data_reg,aluout_mem);
    three_way_mux_32_bit muxb(ForwardB,muxb_out,regout2_ex,data_reg,aluout_mem);

    // Hazard
    HazardUnit hazardunit (INS_ID_mem,INS_ID_ex,rt_ex,ins_id[25:21],ins_id[20:16],PcWrite,IF_IDWrite,Stall);

endmodule
