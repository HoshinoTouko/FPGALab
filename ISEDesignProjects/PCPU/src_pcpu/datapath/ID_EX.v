module ID_EX(
	input clk,
	input [31:0] regdata1_in,
	input [31:0] regdata2_in,
	input [31:0] ext_in,
	input [4:0] rs_in,
	input [4:0] rt_in,
	input [4:0] rd_in,
	input [31:0] pc_add4_in,
	input MemWrite_in,
	input MemtoReg_in,
	input RegWrite_in,
	input RegDst_in,
	input [2:0]ALUOP_in,
	input ALUSrc_in,
	input Branch_in,
	input [2:0]INS_ID_in,
	input [25:0] addr_jump_in,
	input JUMPSrc_in,
	input [1:0]ExtOp_in,

	output reg [1:0]ExtOp_out,
	output reg JUMPSrc_out,
	output reg [25:0] addr_jump_out,
	output reg MemWrite_out,
	output reg MemtoReg_out,
	output reg RegWrite_out,
	output reg RegDst_out,
	output reg [2:0]ALUOP_out,
	output reg ALUSrc_out,
	output reg Branch_out,
	output reg [2:0]INS_ID_out,

	output reg [31:0] regdata1_out,
	output reg [31:0] regdata2_out,
	output reg [31:0] ext_out,
	output reg [4:0] rs_out,
	output reg [4:0] rt_out,
	output reg [4:0] rd_out,
	output reg [31:0] pc_add4_out
);


reg [31:0] pc_add4;
reg [31:0] regdata1;
reg [31:0] regdata2;
reg [31:0] ext;
reg [4:0] rs;
reg [4:0] rt;
reg [4:0] rd;
reg MemWrite;
reg MemtoReg;
reg RegWrite;
reg RegDst;
reg [2:0]ALUOP;
reg ALUSrc;
reg Branch;
reg [2:0]INS_ID;
reg [25:0] addr_jump;
reg JUMPSrc;
reg [1:0] ExtOp;



always@(posedge clk)
begin
	JUMPSrc_out <= JUMPSrc;
	MemWrite_out <= MemWrite;
	MemtoReg_out <= MemtoReg;
	RegWrite_out <= RegWrite;
	RegDst_out <= RegDst;
	ALUOP_out <= ALUOP;
	ALUSrc_out <= ALUSrc;
	Branch_out <= Branch;
	INS_ID_out <= INS_ID;
	regdata1_out <= regdata1;
	regdata2_out <= regdata2;
	ext_out <= ext;
	rs_out <= rs;
	rt_out <= rt;
	rd_out <= rd;
	pc_add4_out <= pc_add4;
	addr_jump_out <= addr_jump;
	ExtOp_out <= ExtOp;
end

always@(negedge clk)
begin
	JUMPSrc <= JUMPSrc_in;
	MemWrite <= MemWrite_in;
	MemtoReg <= MemtoReg_in;
	RegWrite <= RegWrite_in;
	RegDst <= RegDst_in;
	ALUOP <= ALUOP_in;
	ALUSrc <= ALUSrc_in;
	Branch <= Branch_in;
	INS_ID <= INS_ID_in;
	regdata1 <= regdata1_in;
	regdata2 <= regdata2_in;
	ext <= ext_in;
	rs <= rs_in;
	rt <= rt_in;
	rd <= rd_in;
	pc_add4 <= pc_add4_in;
	addr_jump <= addr_jump_in;
	ExtOp <= ExtOp_in;
end

endmodule
