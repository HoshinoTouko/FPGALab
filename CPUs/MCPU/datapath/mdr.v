module mdr(clk, MemData, dout);
    input clk;
	 input [31:0]MemData;
    output reg[31:0]dout;


    initial
        dout = 32'b0;

    always@(posedge clk)begin
		  dout = MemData;
    end

    

endmodule
