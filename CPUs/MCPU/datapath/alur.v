module alur(clk, alurlt, dout);
    input clk;
    input [31:0]alurlt;
    output wire[31:0]dout;

    reg [31:0]register;

    initial
        register = 32'b0;

    always@(posedge clk) begin
        register = alurlt;
    end
    assign dout = register;
endmodule