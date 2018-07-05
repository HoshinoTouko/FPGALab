
module IF_ID(
	input clk,
	input IF_IDWrite,
	input [31:0] ins_in,
	input [31:0] pc_add4_in,
	output reg [31:0] pc_add4_out,
	output reg [31:0] ins_out);

reg [31:0] ins;
reg [31:0] pc_add4;

always@(posedge clk)
begin
	ins_out <= ins;
	pc_add4_out <= pc_add4;
end

always@(negedge clk)
begin
	if(IF_IDWrite)
	begin
		ins <= ins_in;
		pc_add4 <= pc_add4_in;
	end
end

endmodule
