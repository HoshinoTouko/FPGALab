module alu(
    input       [31:0]  alu_src_a,
    input       [31:0]  alu_src_b,
    input       [2:0]   ALUOp,
    output  reg         Zero,
    output  reg [31:0]  alu_output
);
    always@(*)begin
        case(ALUOp)
            3'b000: alu_output = alu_src_a + alu_src_b;
            3'b101: alu_output = alu_src_a - alu_src_b; 
            3'b001: alu_output = alu_src_a & alu_src_b;
            3'b010: alu_output = ~(alu_src_a | alu_src_b);
            3'b011: alu_output = (alu_src_a < alu_src_b) ? 32'd1 : 32'd0;
            3'b100: alu_output = alu_src_a | alu_src_b;
            default:
                alu_output = 32'b0;
        endcase
        Zero = (alu_output == 32'b0) ? 1'b1 : 1'b0;
    end
endmodule
