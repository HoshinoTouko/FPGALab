module two_way_mux_32_bit(
  input wire signal,
  output wire[31:0] output_data,
  input wire[31:0] d0,
  input wire[31:0] d1
);

  assign output_data = signal ? d1 : d0;

endmodule

module three_way_mux_32_bit(
	input wire [1:0] signal,
	output wire [31:0] output_data,
	input wire [31:0] d0,
	input wire [31:0] d1,
	input wire [31:0] d2
);

assign output_data = signal == 0?d0:(signal == 1?d1:d2);

endmodule 
