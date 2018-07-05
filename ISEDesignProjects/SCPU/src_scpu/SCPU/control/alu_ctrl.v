`include "define/ctrl_encode_def.v"

module alu_ctrl(
    input [1:0]ALUOp,
    input [5:0]Funct,
    output reg[2:0]ALUctrl
);
    always@(*)begin
        if(ALUOp == `RtypeOP)begin
            if(Funct == 6'h20)begin //add
                ALUctrl = 3'b000;
            end
            else if(Funct == 6'h24)begin //and
                ALUctrl = 3'b001;
            end
            else if(Funct == 6'h27)begin //nor
                ALUctrl = 3'b010;
            end
            else if(Funct == 6'h2a)begin //sltu
                ALUctrl = 3'b011;
            end
            else if(Funct == 6'h25)begin //or
                ALUctrl = 3'b100;
            end
        end
        else if(ALUOp == `lwOP || ALUOp == `swOP)begin
            ALUctrl = 3'b000;
        end
		  else if(ALUOp == `beqOP)begin
            ALUctrl = 3'b101;
        end
        else
        begin
            ALUctrl = 3'h000;
        end
    end
endmodule
