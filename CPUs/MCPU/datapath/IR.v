module IR(
    input           clk, 
    input   [31:0]  din, 
    input           IRWrite, 
    output  [31:0]  dout
);    
    reg     [31:0]  InstructionReg;

    initial begin
        InstructionReg = 32'b0;
    end

    always@(posedge clk)begin
        if(IRWrite)
            InstructionReg = din;
    end

    assign dout = InstructionReg;
endmodule
