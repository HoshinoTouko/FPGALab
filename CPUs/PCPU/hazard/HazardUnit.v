`include "instruction_def.v"
module HazardUnit(
	input       [2:0]   INS_ID_mem,
	input       [2:0]   INS_ID_ex,
	input       [4:0]   rt_ex,
	input       [4:0]   rs_id,
	input       [4:0]   rt_id,
	output reg          PcWrite,
	output reg          IF_IDWrite,
	output reg          Stall
);

always@(*) begin
	if ((INS_ID_mem == `INS_ID_BEQ) || (INS_ID_mem == `INS_ID_J)) begin
		PcWrite = 1;
		IF_IDWrite = 1;
		Stall = 1;
	end

	else if(INS_ID_ex == `INS_ID_LW && ((rt_id == rt_ex) || (rs_id == rt_ex))) begin
		PcWrite = 0;
		IF_IDWrite = 0;
		Stall = 1;
	end

	else if((INS_ID_ex == `INS_ID_BEQ) || (INS_ID_ex == `INS_ID_J)) begin
		PcWrite = 1;
		IF_IDWrite = 1;
		Stall = 1;
	end
    
	else begin
		PcWrite = 1;
		IF_IDWrite = 1;
		Stall = 0;
	end
end

endmodule
