module MCPU(
    input clk,
    input reset,
    input MIO_ready,
    input [31:0]Data_in,
    input INT,

    output mem_w,
    output [31:0]inst_out,
    output [31:0]PC_out,
    output [31:0]Addr_out,
    output [31:0]Data_out,
    output CPU_MIO
);

    // Init variables
    wire        PCctrl;
    wire        IRWrite;
    wire        MemWrite;
    wire        PCWrite;
    wire        PCWriteCond;
    wire        RegWrite;
    wire        Zero;
    wire        extop;
    wire        dmEXTop;
    wire IorD;
    wire [1:0]  ALUSrcA;
    wire [1:0]  ALUSrcB;
    wire [1:0]  PCSource;
    wire [1:0]  MemtoReg;
    wire [1:0]  RegDst;
    wire [1:0]  lsop;
    wire [3:0]  ALUOp;
    wire [3:0]  be_out;
    wire [3:0]  ALUctrlOp;
    wire [4:0]  mux1out;
    wire [31:0] PCin;
    wire [31:0] PCout;
    wire [31:0] IRout;
    wire [31:0] RFout1;
    wire [31:0] RFout2;
    wire [31:0] MDrout;
    wire [31:0] mux2out;
    wire [31:0] ALUinA;
    wire [31:0] ALUinB;
    wire [31:0] ALUrlt;
    wire [31:0] ALUrout;
    wire [31:0] rfrAout;
    wire [31:0] rfrBout;
    wire [31:0] EXTout;

    assign PCctrl = PCWrite | (PCWriteCond & Zero);

    // Units
    pc PC(clk, PCin, PCctrl, PCout);
    mdr MDr(clk, Data_in, MDrout);

    // ALU
    alu ALU(IRout[20:16], ALUinA, ALUinB, ALUctrlOp, ALUrlt, Zero);
    alur ALUr(clk, ALUrlt, ALUrout);
    beext beEXT(ALUrout[1:0], lsop, be_out);

    // IR
    IR ir(clk, Data_in, IRWrite, IRout);
    ext EXT(IRout[15:0], extop, EXTout);

    // Register file
    rf Register(IRout[25:21], IRout[20:16], mux1out, mux2out, RegWrite, RFout1, RFout2);
    rfr rfrA(clk, RFout1, rfrAout);
    rfr rfrB(clk, RFout2, rfrBout);

    // Control units
    ctrl Control(clk, IRout[31:26], IRout[5:0], IRWrite, MemtoReg, MemWrite, PCWrite, PCWriteCond, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, lsop, extop, dmEXTop, IorD);
    aluctrl ALUControl(ALUOp, IRout[5:0], ALUctrlOp);

    // Mux
    four_way_mux_5_bit IRtoREG(IRout[20:16], IRout[15:11], 5'd31, 5'h0, RegDst, mux1out);
    two_way_mux_32_bit IORD(PCout, ALUrout, IorD, Addr_out);
    four_way_mux_32_bit muxPC(ALUrlt, ALUrout, {PCout[31:28], IRout[25:0], 2'b00}, 32'h0, PCSource, PCin);
    four_way_mux_32_bit AtoALU(PCout, rfrAout, (rfrAout+{27'h0, IRout[10:6]}) , 32'h0, ALUSrcA, ALUinA);
    four_way_mux_32_bit BtoALU(rfrBout, 32'h4, EXTout, {EXTout[29:0], 2'h0}, ALUSrcB, ALUinB);
    four_way_mux_32_bit MDRtoRF(ALUrout, MDrout, PCout, 32'h0, MemtoReg, mux2out);

    // Assignment
    assign inst_out = Data_in;
    assign mem_w = MemWrite;
    assign PC_out = PCout;
    assign Data_out = rfrBout;

endmodule



