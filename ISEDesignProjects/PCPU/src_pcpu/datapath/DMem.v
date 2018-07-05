module DMem(	
    input [31:0] DataAdr,
    input [31:0] DataIn,
    input 		 DMemW,
    input 		 clk,
    output[31:0] DataOut
);
	
	reg [31:0]  DMem[63:0];
	integer i;

	initial begin
            for (i = 0; i < 31; i = i + 1)
        DMem[i] = 0;
    end
	
	always@(negedge clk) begin
		if(DMemW) begin
			DMem[DataAdr] <= DataIn;
			$display("Dmem write %x at %d",DataIn,DataAdr);
        end
    end

	assign DataOut = (DataAdr == 32'hf0000000)?123:DMem[DataAdr];
endmodule