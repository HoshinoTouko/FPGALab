module two_way_mux_32_bit(
    input       [31:0]  d0,
    input       [31:0]  d1,
    input               select,
    output reg  [31:0]  result
);
    always@(*)
    begin
        result = select ? d1 : d0;
    end
endmodule

module four_way_mux_5_bit(
    input       [4:0]   d0,
    input       [4:0]   d1,
    input       [4:0]   d2,
    input       [4:0]   d3,
    input       [1:0]   select,
    output reg  [4:0]   result
);
    always@(*)begin
        case(select)
            2'b00: result = d0;
            2'b01: result = d1;
            2'b10: result = d2;
            2'b11: result = d3;
        endcase
    end
endmodule
