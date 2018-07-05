module MEM_WB(
	input clk,
	input [31:0] memdata_in,
	input [31:0] aludata_in,
	input [4:0] wrreg_in,
	input MemtoReg_in,
	input RegWrite_in,
	input [2:0]INS_ID_in,
	output reg [2:0]INS_ID_out,
	output reg MemtoReg_out,
	output reg RegWrite_out,
	output reg [31:0] memdata_out,
	output reg [31:0] aludata_out,
	output reg [4:0] wrreg_out
);

reg [31:0] memdata;
reg [31:0] aludata;
reg [4:0] wrreg;
reg MemtoReg;
reg RegWrite;
reg [2:0]INS_ID;

always@(posedge clk)
begin
	memdata_out <= memdata;
	aludata_out <= aludata;
	wrreg_out <= wrreg;
	MemtoReg_out <= MemtoReg;
	RegWrite_out <= RegWrite;
	INS_ID_out <= INS_ID;
end

always@(negedge clk)
begin
	memdata <= memdata_in;
	aludata <= aludata_in;
	wrreg <= wrreg_in;
	MemtoReg <= MemtoReg_in;
	RegWrite <= RegWrite_in;
	INS_ID <= INS_ID_in;
end

endmodule
