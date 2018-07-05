module SCPU(
    input           clk,
    input           reset,
    input   [31:0]  inst_in,
    input   [31:0]  Data_in,
    input           INT,
    input           MIO_ready,
    
    output  [31:0]  PC_out,
    output  [31:0]  Addr_out, 
    output  [31:0]  Data_out,
    output          mem_w,
    output          CPU_MIO
);

    wire Jump;
    wire Mem2Reg;
    wire Branch;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire Zero;
    wire [1:0] RegDst;
    wire [2:0] ALUOp;
    wire [2:0] ALUctrl;
    wire [4:0] writeReg;
    wire [31:0] pcInput;
    wire [31:0] PCout;
    wire [31:0] IMout;
    wire [31:0] add4out;
    wire [31:0] writeData;
    wire [31:0] DmOut;
    wire [31:0] addResult;
    wire [31:0] newpc;
    wire [31:0] beqOut;
    wire [31:0] RFdout1;
    wire [31:0] RFdout2;
    wire [31:0] extOut;
    wire [31:0] aluIn1;
    wire [31:0] aluIn2;
    wire [31:0] ALUResult;

    // Control units
    ctrl Control(
        .OP(IMout[31:26]), 
        .RegDst(RegDst), 
        .Jump(Jump), 
        .Branch(Branch), 
        .Mem2Reg(Mem2Reg), 
        .ALUOp(ALUOp), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite)
    );
    alu_ctrl alu_Control(ALUOp, IMout[5:0], ALUctrl);

    // Datapath
    pc PC(
        .clk(clk),
        .reset(reset),
        .input_pc(pcInput), 
        .output_pc(PCout)
    );
    add4 pcadd4(
        .old_pc(PCout), 
        .add4_out(add4out)
    );
    RF rf(
        .clk(clk),
        .read_address_1(IMout[25:21]), 
        .read_address_2(IMout[20:16]), 
        .write_address(writeReg), 
        .write_data(writeData), 
        .reg_write(RegWrite),
        .read_data_1(RFdout1), 
        .read_data_2(RFdout2)
    );
    EXT signEXT(
        .immediate(IMout[15:0]), 
        .EXTOp(2'b01), 
        .ext_output(extOut)
    );
    alu Alu(
        .alu_src_a(aluIn1), 
        .alu_src_b(aluIn2), 
        .ALUOp(ALUctrl), 
        .Zero(Zero), 
        .alu_output(ALUResult)
    );
    addAddress aa(add4out, {extOut[29:0], 2'b00}, addResult);
    
    // Mux
    four_way_mux_5_bit IM2RFMux(
        .d0(IMout[20:16]), 
        .d1(IMout[15:11]), 
        .d2(5'b11111), 
        .d3(5'bXXXXX), 
        .select(RegDst), 
        .result(writeReg)
    );
    two_way_mux_32_bit RF2ALUMux(
        .d0(RFdout2), 
        .d1(extOut), 
        .select(ALUSrc), 
        .result(aluIn2)
    );
    two_way_mux_32_bit BeqMux(
        .d0(add4out), 
        .d1(addResult), 
        .select(Branch&Zero), 
        .result(beqOut)
    );
    two_way_mux_32_bit DM2RFMux(
        .d0(ALUResult), 
        .d1(DmOut), 
        .select(Mem2Reg), 
        .result(writeData)
    );
    two_way_mux_32_bit JumpMux(
        .d0(beqOut), 
        .d1({add4out[31:28], IMout[25:0], 2'b00}), 
        .select(Jump),
        .result(newpc)
    );

    // Assignments
    assign aluIn1 = RFdout1;
    assign pcInput = newpc;

    assign PC_out = PCout;
    assign IMout = inst_in;
    assign mem_w = MemWrite;
    assign Addr_out = ALUResult;
    assign DmOut = Data_in;
    assign Data_out = RFdout2;

endmodule
