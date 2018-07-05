module rfr(clk, din, dout);
    input clk;
    input [31:0]din;
    output wire[31:0]dout;

    reg [31:0]register;

    initial
        register = 32'b0;

    always@(posedge clk)begin
        register = din;
    end

    assign dout = register;
endmodule