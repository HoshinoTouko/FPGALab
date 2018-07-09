`include "instruction_def.v"
module ForwardUnit(
	input       [4:0]   rs_id,
	input       [4:0]   rt_id,
	input       [4:0]   rd_mem,
	input       [4:0]   rd_wb,
	input       [2:0]   INS_ID_mem,
	input       [2:0]   INS_ID_wb,
	output reg  [1:0]   ForwardA,
	output reg  [1:0]   ForwardB
);


always@(*) begin
	if(INS_ID_mem == `INS_ID_RTYPE && rd_mem != 0 && rs_id == rd_mem)
		ForwardA = 2'b10;
	else if((INS_ID_wb == `INS_ID_RTYPE || INS_ID_wb == `INS_ID_LW) && rd_wb != 0 && rs_id == rd_wb)
		ForwardA = 2'b01;
	else
		ForwardA = 2'b00;
	
	if(INS_ID_mem == `INS_ID_RTYPE && rd_mem != 0 && rt_id == rd_mem)
		ForwardB = 2'b10;
	else if((INS_ID_wb == `INS_ID_RTYPE || INS_ID_wb == `INS_ID_LW) && rd_wb != 0 && rt_id == rd_wb)
		ForwardB = 2'b01;
	else
		ForwardB = 2'b00;

end

endmodule
