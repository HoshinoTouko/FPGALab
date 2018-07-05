module pc(
    input clk,
    input reset,
    input [31:0]input_pc,
    output reg [31:0]output_pc
);  
	always@(posedge clk) begin
        output_pc <= input_pc;
        if(reset == 1) output_pc <= 32'h00400000;
    end
endmodule
