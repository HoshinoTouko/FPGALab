module EXT(
    input       [15:0]  immediate,
    input       [1:0]   EXTOp,
    output  reg [31:0]  ext_output
);
    always@(*) begin
      case(EXTOp)
        2'b00: ext_output = {16'b0, immediate};
        2'b01: ext_output = immediate[15]?{~16'b0, immediate}:{16'b0, immediate};
        2'b10: ext_output = {immediate, 16'b0};
        default:
            ext_output = 32'b0;
      endcase
    end
endmodule
