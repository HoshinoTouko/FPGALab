module two_way_mux_32_bit(d0, d1, select, dout);
    input   [31:0]  d0;
    input   [31:0]  d1;
    input           select;
    output  [31:0]  dout;

    assign dout = select ? d1 : d0;
endmodule

module four_way_mux_5_bit(d0, d1, d2, d3, select, dout);
    input       [4:0]   d0;
    input       [4:0]   d1;
    input       [4:0]   d2;
    input       [4:0]   d3;
    input       [1:0]   select;
    output  reg [4:0]   dout;

    always@(*) begin
        case(select)
            2'b00: dout = d0;
            2'b01: dout = d1;
            2'b10: dout = d2;
            2'b11: dout = d3;
        endcase
    end
endmodule

module four_way_mux_32_bit(d0, d1, d2, d3, select, dout);
    input       [31:0]  d0;
    input       [31:0]  d1;
    input       [31:0]  d2;
    input       [31:0]  d3;
    input       [1:0]   select;
    output reg  [31:0]  dout;

    always@(*) begin
        case(select)
            2'b00: dout = d0;
            2'b01: dout = d1;
            2'b10: dout = d2;
            2'b11: dout = d3;
        endcase
    end
endmodule
