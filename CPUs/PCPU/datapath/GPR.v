
module GPR(	input clk,
		input WriteData,
		input [4:0] WrReg,ReReg1,ReReg2,
		input [31:0] WData,
		output [31:0] DataOut1,DataOut2
);
	
	reg [31:0] Gpr[31:0];
	integer i;
	initial 
	begin
	  for(i = 0; i < 32; i = i + 1)
     		 Gpr[i] = 0;
 	 end
	
	always@(negedge clk)
	begin
		if(WriteData == 1)
		begin
			Gpr[WrReg] <= WData;
		end
	


	end
	assign DataOut1 = (ReReg1==0)?0:Gpr[ReReg1];
	assign DataOut2 = (ReReg2==0)?0:Gpr[ReReg2];
	
endmodule