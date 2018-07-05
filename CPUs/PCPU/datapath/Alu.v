`include "ctrl_encode_def.v"
module Alu(	
		input  [31:0] 	DataIn1,
		input  [31:0]	DataIn2,
		input  [2:0]	AluCtrl,
		output reg[31:0]AluResult,	
		output reg	[31:0]Zero);
		
	initial								
	begin
		Zero = 0;
		AluResult = 0;
	end	
	
	always@(DataIn1 or DataIn2 or AluCtrl)
	begin
		if(AluCtrl == `ALUOP_ADD)
			AluResult = DataIn1+DataIn2;
		else
			if(AluCtrl == `ALUOP_SUB)
				AluResult = DataIn1-DataIn2;
			else
			    if(AluCtrl == `ALUOP_OR)
					AluResult = DataIn1|DataIn2;
				else
					if(AluCtrl == `ALUOP_NOR)
						AluResult = (~DataIn1|DataIn2)&(~DataIn2|DataIn1);
					else
						if(AluCtrl  == `ALUOP_AND)
							AluResult = DataIn1&DataIn2;
						else
							if(AluCtrl ==`ALUOP_SLT)
								AluResult = DataIn1<DataIn2?1:0;
		
		if(AluResult == 0)
			Zero = 1;
		else
			Zero = 0;
	end

endmodule