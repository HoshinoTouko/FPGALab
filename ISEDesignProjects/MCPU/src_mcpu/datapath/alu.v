`include "./define/alu_define.v"
module alu(
    input       [4:0]   rt, 
    input       [31:0]  alu_src_a, 
    input       [31:0]  alu_src_b, 
    input       [3:0]   ALUOp, 
    output reg  [31:0]  alu_output, 
    output reg          Zero
);
    always@(*) begin
        case(ALUOp)
            `ADD:   alu_output = alu_src_a + alu_src_b;
            `SUB:   alu_output = alu_src_a - alu_src_b;
            `AND:   alu_output = alu_src_a & alu_src_b;
            `OR:    alu_output = alu_src_a | alu_src_b;
            `XOR:   alu_output = alu_src_a ^ alu_src_b;
            `NOR:   alu_output = ~(alu_src_a | alu_src_b);
            `BGTZ:  alu_output = ((alu_src_a[31]==0) && (alu_src_a != 0))?32'h0:32'h1;
            `BLEZ:  alu_output = ((alu_src_a[31]==0) && (alu_src_a != 0))?32'h1:32'h0;
            `BLTZ:  alu_output = (alu_src_a[31]==0)?{31'h0, ~rt[0]}:{31'h0, rt[0]};
            `BNE:   alu_output = (alu_src_a==alu_src_b)?32'h1:32'h0;
            `SLT:   alu_output = {31'b0, (alu_src_a[31] | alu_src_b[31]) ^ ((alu_src_a < alu_src_b)?1'b1:1'b0)};
            `SLTU:  alu_output = {31'b0, (alu_src_a<alu_src_b)?1'b1:1'b0};
            `SLL:   alu_output = alu_src_b << alu_src_a[4:0];
            `SRL:   alu_output = alu_src_b >> alu_src_a[4:0];
            `SRA:   alu_output = alu_src_b >> alu_src_a[4:0] | ({32{alu_src_b[31]}} << (6'd32-{1'b0, alu_src_a[4:0]}));
            `LU:    alu_output = {alu_src_b[15:0], 16'b0};
            default:
                alu_output = 32'b0;
        endcase
        if(alu_output == 0)
            Zero = 1'b1;
        else
            Zero = 1'b0;
    end
endmodule
