`include "./define/ctrl_encode_def.v"
`include "./define/instruction_def.v"
module Ctrl(input clk,
			input [31:0] ins,
			input Stall,
			output reg MemWrite,
			output reg MemtoReg,
			output reg RegWrite,
			output reg RegDst,
			output reg [2:0]ALUOP,
			output reg ALUSrc,
			output reg Branch,
			output reg [2:0]INS_ID,
			output reg JUMPSrc,
			output reg [1:0]ExtOp
);

initial
	begin
		MemWrite = 0;
		MemtoReg = 0;
		RegWrite = 0;
		RegDst = 0;
		ALUOP = `ALUOP_ADD;
		ALUSrc = 0;
		Branch = 0;
		INS_ID = `INS_ID_OTHERS;
		JUMPSrc = 0;
		ExtOp = `EXTOP_ZERO;
	end

always@(ins or Stall)
begin
	if(Stall)
	begin
		MemWrite = 0;
		MemtoReg = 0;
		RegWrite = 0;
		RegDst = 0;
		ALUOP = `ALUOP_ADD;
		ALUSrc = 0;
		Branch = 0;
		INS_ID = `INS_ID_OTHERS;
		JUMPSrc = 0;
		ExtOp = `EXTOP_ZERO;
	end
	else
	begin
	case(ins[31:26])
	`CTRL_OP_RTYPE:
		case(ins[5:0])
		`CTRL_FUNCT_ADD:
		begin
			MemWrite = 0;
			RegWrite = 1;
			MemtoReg = 0;
			RegDst = 1;
			ALUOP = `ALUOP_ADD;
			ALUSrc = 0;
			Branch = 0;
			INS_ID = `INS_ID_RTYPE;
			JUMPSrc = 0;
			ExtOp = `EXTOP_ZERO;
		end
		`CTRL_FUNCT_AND:
		begin
			MemWrite = 0;
			RegWrite = 1;
			MemtoReg = 0;
			RegDst = 1;
			ALUOP = `ALUOP_AND;
			ALUSrc = 0;
			Branch = 0;
			INS_ID = `INS_ID_RTYPE;
			JUMPSrc = 0;
			ExtOp = `EXTOP_ZERO;
		end
		`CTRL_FUNCT_NOR:
		begin
			MemWrite = 0;
			RegWrite = 1;
			MemtoReg = 0;
			RegDst = 1;
			ALUOP = `ALUOP_NOR;
			ALUSrc = 0;
			Branch = 0;
			INS_ID = `INS_ID_RTYPE;
			JUMPSrc = 0;
			ExtOp = `EXTOP_ZERO;
		end
		`CTRL_FUNCT_OR:
		begin
			MemWrite = 0;
			RegWrite = 1;
			MemtoReg = 0;
			RegDst = 1;
			ALUOP = `ALUOP_OR;
			ALUSrc = 0;
			Branch = 0;
			INS_ID = `INS_ID_RTYPE;
			JUMPSrc = 0;
			ExtOp = `EXTOP_ZERO;
		end
		`CTRL_FUNCT_SLT:
		begin
			MemWrite = 0;
			RegWrite = 1;
			MemtoReg = 0;
			RegDst = 1;
			ALUOP = `ALUOP_SLT;
			ALUSrc = 0;
			Branch = 0;
			INS_ID = `INS_ID_RTYPE;
			JUMPSrc = 0;
			ExtOp = `EXTOP_ZERO;
		end
		endcase
	`CTRL_OP_LW:
	begin
		MemWrite = 0;
		RegWrite = 1;
		MemtoReg = 1;
		RegDst = 0;
		ALUOP = `ALUOP_ADD;
		ALUSrc = 1;
		Branch = 0;
		INS_ID = `INS_ID_LW;
		JUMPSrc = 0;
		ExtOp = `EXTOP_SIGNED;
	end
	`CTRL_OP_SW:
	begin
		MemWrite = 1;
		RegWrite = 0;
		MemtoReg = 0;
		RegDst = 0;
		ALUOP = `ALUOP_ADD;
		ALUSrc = 1;
		Branch = 0;
		INS_ID = `INS_ID_SW;
		JUMPSrc = 0;
		ExtOp = `EXTOP_SIGNED;
	end
	`CTRL_OP_BEQ:
	begin
		MemWrite = 0;
		RegWrite = 0;
		MemtoReg = 0;
		RegDst = 0;
		ALUOP = `ALUOP_SUB;
		ALUSrc = 0;
		Branch = 1;
		INS_ID = `INS_ID_BEQ;
		JUMPSrc = 0;
		ExtOp = `EXTOP_ZERO;
	end
	`CTRL_OP_J:
	begin
		MemWrite = 0;
		RegWrite = 0;
		MemtoReg = 0;
		RegDst = 0;
		ALUOP = `ALUOP_ADD;
		ALUSrc = 0;
		Branch = 0;
		INS_ID = `INS_ID_J;
		JUMPSrc = 1;
		ExtOp = `EXTOP_ZERO;
	end
	endcase
	end
end

endmodule