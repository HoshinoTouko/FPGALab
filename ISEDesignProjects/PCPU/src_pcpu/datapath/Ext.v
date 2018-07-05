`include "./define/ctrl_encode_def.v"

module Ext(
  input wire[15:0] Immediate,
  input [1:0] ExtOp,
  output reg[31:0] Immediate_ext
);



  initial
  begin
    Immediate_ext = 32'b00;
  end
  
  always @(Immediate or ExtOp)
		begin
			if(ExtOp == `EXTOP_ZERO)
				Immediate_ext <= {{16'b0}, Immediate[15:0]};
			else
				if(ExtOp == `EXTOP_SIGNED)
					Immediate_ext <= {{16{Immediate[15]}}, Immediate[15:0]};
				else
			  	 	 if(ExtOp ==  `EXTOP_INST)
							Immediate_ext <= 32'b0;

  		end
endmodule