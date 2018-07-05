
module EX_MEM(
	input clk,

	input [31:0] aluresult_in,
	input [31:0] regdata2_in,
	input [4:0] wrreg_in,
	input MemWrite_in,
	input MemtoReg_in,
	input RegWrite_in,


	input [2:0]INS_ID_in,
	output reg [2:0]INS_ID_out,

	output reg MemWrite_out,
	output reg MemtoReg_out,
	output reg RegWrite_out,

	output reg [31:0] aluresult_out,
	output reg [31:0] regdata2_out,
	output reg [4:0] wrreg_out
);


reg [31:0] aluresult;
reg [31:0] regdata2;
reg [4:0] wrreg; 
reg MemWrite;
reg MemtoReg;
reg RegWrite;


reg [2:0]INS_ID;

always@(posedge clk)
begin

	aluresult_out <= aluresult;
	regdata2_out <= regdata2;
	wrreg_out <= wrreg;
	MemWrite_out <= MemWrite;
	MemtoReg_out <= MemtoReg;
	RegWrite_out <= RegWrite;


	INS_ID_out <= INS_ID;
end

always@(negedge clk)
begin

	aluresult <= aluresult_in;
	regdata2 <= regdata2_in;
	wrreg <= wrreg_in;
	MemWrite <= MemWrite_in;
	MemtoReg <= MemtoReg_in;
	RegWrite <= RegWrite_in;

	INS_ID <= INS_ID_in;
end

endmodule