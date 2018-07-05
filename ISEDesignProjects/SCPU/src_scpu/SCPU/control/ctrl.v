`include "define/ctrl_encode_def.v"

module ctrl(
    input       [5:0]   OP,
    output reg  [1:0]   RegDst,
    output reg          Jump,
    output reg          Branch,
    output reg          Mem2Reg,
    output reg  [2:0]   ALUOp,
    output reg          MemWrite,
    output reg          ALUSrc,
    output reg          RegWrite
);
    always@(*) begin
        if(OP == `RtypeINPUT)begin
            RegDst <= 2'b01;
            Jump <= 1'b0;
            Branch <= 1'b0;
            Mem2Reg <= 1'b0;
            ALUOp <= `RtypeOP;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b1;
        end
        if(OP == `lwINPUT)begin
            RegDst <= 2'b00;
            Jump <= 1'b0;
            Branch <= 1'b0;
            Mem2Reg <= 1'b1;
            ALUOp <= `lwOP;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b1; 
        end
        if(OP == `swINPUT)begin
            Jump <= 1'b0;
            Branch <= 1'b0;
            ALUOp <= `swOP;
            MemWrite <= 1'b1;
            ALUSrc <= 1'b1;
            RegWrite <= 1'b0;
        end
        if(OP == `beqINPUT)begin
            Jump <= 1'b0;
            Branch <= 1'b1;
            ALUOp <= `beqOP;
            MemWrite <= 1'b0;
            ALUSrc <= 1'b0;
            RegWrite <= 1'b0;
        end
        if(OP == `jINPUT)begin
            RegDst <= 2'b10;
            Jump <= 1'b1;
            Branch <= 1'b0;
            MemWrite <= 1'b0;
            RegWrite <= 1'b0;
        end
    end
endmodule
