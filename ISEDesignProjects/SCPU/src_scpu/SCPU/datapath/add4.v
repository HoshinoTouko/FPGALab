module add4(
    input   [31:0]old_pc,
    output  [31:0]add4_out
);
    assign add4_out = old_pc + 4;

endmodule
