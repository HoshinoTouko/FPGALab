`include "./ctrl_define.v"
`include "./Itype_define.v"
`include "./be_define.v"
module ctrl(clk, instruction, funct, IRWrite, MemtoReg, MemWrite, PCWrite, PCWriteCond, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, lsop, extop, dmEXTop, IorD);
    input clk;
    input [31:26]instruction;
    input [5:0]funct;
    output reg IRWrite;
    output reg[1:0] MemtoReg;
    output reg MemWrite;
    output reg PCWrite;
    output reg PCWriteCond;
    output reg[1:0] PCSource;
    output reg[3:0] ALUOp;
    output reg[1:0] ALUSrcB;
    output reg[1:0] ALUSrcA;
    output reg RegWrite;
    output reg[1:0] RegDst;
    output reg [1:0]lsop;
    output reg extop;
    output reg dmEXTop;
    output reg IorD;

    integer status;
    initial
    begin
        status = 0;
    end

    always@(posedge clk)begin
        PCWrite = 0;
        IRWrite = 0;
        MemWrite = 0;
        RegWrite = 0;
        extop = 0;
        dmEXTop = 0;

        if(status==0)//周期一
        begin
            IorD = 1'b0;
            ALUSrcA = 2'b00;
            ALUSrcB = 2'b01;
            ALUOp = 4'h0;
            PCSource = 2'b00;
            PCWrite = 1'b1;
            status = 1;
				IRWrite = 1'b1;
        end
        else if(status==1)
        begin
            ALUSrcA = 2'b00;
            ALUSrcB = 2'b11;
            ALUOp = 4'h0;
            status = 2;
        end
        else
        //module ctrl(clk, instruction, IRWrite, MemtoReg, MemWrite, IorD, PCWrite, PCWriteCond, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, lsop);
        begin
            case(instruction)
                //R-type
                `rtypeOp:
                begin
                    if(funct==6'h9)begin//jalr
                        if(status==2)begin
                            ALUSrcA = 2'b10;
                            ALUSrcB = 2'b00;
                            ALUOp = 4'h2;
                            PCSource = 2'b00;
                            MemtoReg = 2'b10;
                            RegDst = 2'b01;
                            RegWrite = 1'b1;
                            status = 0;
                            PCWrite = 1'b1;
                        end
                    end
                    else if(funct==6'h8)begin//jr
                        if(status==2)begin
                            ALUSrcA = 2'b10;
                            ALUSrcB = 2'b00;
                            PCSource = 2'b00;
                            ALUOp = 4'h2;
                            PCWrite = 1'b1;
                            status = 0;
                        end
                    end 
                    else
                    begin   
                        if(status==2)begin
                            ALUSrcA = 2'b10;
                            ALUSrcB = 2'b00;
                            ALUOp = 4'h2;
                            status = 3;
                            RegDst = 2'b01;
                            MemtoReg = 2'b00;
                        end
                        else if(status==3)begin
                            RegWrite = 1'b1;
                            status = 0;
                        end
                    end
                end
                //load data
                `lbOp,
                `lbuOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        ALUOp = 4'h0;
                        PCWriteCond = 1'b0;
                        status = 3;
                    end
                    else if(status==3)begin
                        IorD = 1'b1;
                        PCWriteCond = 1'b0;
                        lsop = `BYTEop;
                        status = 4;
                        if(instruction==`lbuOp)
                            dmEXTop = 1;
                        MemtoReg = 2'b01;
                    
                    end
                    else
                    begin
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        PCWriteCond = 1'b0;
                        status = 0;
                    end
                end
                `lhOp,
                `lhuOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        ALUOp = 4'h0;
                        PCWriteCond = 1'b0;
                        status = 3;
                    end
                    else if(status==3)begin
                        IorD = 1'b1;
                        PCWriteCond = 1'b0;
                        lsop = `HALFop;
                        status = 4;
                        if(instruction==`lhuOp)
                            dmEXTop = 1;
                        
                        
                    end
                    else
                    begin
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
								MemtoReg = 2'b01;
                        PCWriteCond = 1'b0;
                        status = 0;
                    end
                end
                `lwOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        ALUOp = 4'h0;
                        PCWriteCond = 1'b0;
                        status = 3;
                    end
                    else if(status==3)begin
                        IorD = 1'b1;
                        PCWriteCond = 1'b0;
                        lsop = `WORDop;
                        status = 4;
                    end
                    else
                    begin
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
								MemtoReg = 2'b01;
                        PCWriteCond = 1'b0;
                        status = 0;
                    end
                end
                //store data
                `sbOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        ALUOp = 4'h0;
                        PCWriteCond = 1'b0;
                        status = 3;
                    end
                    else if(status==3)begin
                        IorD = 1'b1;
                        MemWrite = 1'b1;
                        PCWriteCond = 1'b0;
                        lsop = `BYTEop;
                        status = 0;
                    end
                end
                `shOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        ALUOp = 4'h0;
                        PCWriteCond = 1'b0;
                        status = 3;
                    end
                    else if(status==3)begin
                        IorD = 1'b1;
                        MemWrite = 1'b1;
                        PCWriteCond = 1'b0;
                        lsop = `HALFop;
                        status = 0;
                    end
                end
                `swOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        ALUOp = 4'h0;
                        PCWriteCond = 1'b0;
                        status = 3;
                    end
                    else if(status==3)begin
                        IorD = 1'b1;
                        MemWrite = 1'b1;
                        PCWriteCond = 1'b0;
                        lsop = `WORDop;
                        status = 0;
                    end
                end
                //I-type
                `andiOp,
                `oriOp,
                `xoriOp,
                `addiOp,
                `addiuOp,
                `luiOp,
                `sltiOp,
                `sltiuOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b10;
                        if(instruction==`andiOp)
                            ALUOp = `ANDI;
                        else if(instruction==`oriOp)
                            ALUOp = `ORI;
                        else if(instruction==`xoriOp)
                            ALUOp = `XORI;
                        else if(instruction==`addiOp)
                            ALUOp = `ADDI;
                        else if(instruction==`addiuOp)begin
                            ALUOp = `ADDIU;
                            extop = 1;
                        end
                        else if(instruction==`luiOp)
                            ALUOp = `LUI;
                        else if(instruction==`sltiOp)
                            ALUOp = `SLTI;
                        else if(instruction==`sltiuOp)
                            ALUOp =`SLTIU;
                        PCWriteCond = 1'b0;
                        status = 3;
                        RegDst = 2'b00;
                        MemtoReg = 2'b00;
                    end
                    else if(status==3)begin
                        RegWrite = 1'b1;
                        PCWriteCond = 1'b0;
                        status = 0;
                    end
                end
                //branch
                `beqOp:
                begin  
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b00;
                        ALUOp = 4'h1;
                        PCSource = 2'b01;
                        PCWriteCond = 1'b1;
                        status = 0;
                    end
                end
                `bneOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b00;
                        ALUOp = 4'hb;
                        PCSource = 2'b01;
                        PCWriteCond = 1'b1;
                        status = 0;
                    end
                end
                `bgtzOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b00;
                        ALUOp = 4'hc;
                        PCSource = 2'b01;
                        PCWriteCond = 1'b1;
                        status = 0;
                    end
                end
                `blezOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b00;
                        ALUOp = 4'hd;
                        PCSource = 2'b01;
                        PCWriteCond = 1'b1;
                        status = 0;
                    end
                end
                `bltzOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b00;
                        ALUOp = 4'he;
                        PCSource = 2'b01;
                        PCWriteCond = 1'b1;
                        status = 0;
                    end
                end
                `bgezOp:
                begin
                    if(status==2)begin
                        ALUSrcA = 2'b01;
                        ALUSrcB = 2'b00;
                        ALUOp = 4'hf;
                        PCSource = 2'b01;
                        PCWriteCond = 1'b1;
                        status = 0;
                    end
                end
                //Jump
                `jOp:
                begin
                    if(status==2)begin
                        PCSource = 2'b10;
                        PCWrite = 1'b1;
                        status = 0;
                    end
                end
                `jalOp:
                begin
                    if(status==2)begin
                        PCSource = 2'b10;
                        PCWrite = 1'b1;
                        status = 0;
                        MemtoReg = 2'b10;
                        RegDst = 2'b10;
                        RegWrite = 1'b1;
                    end
                end
            endcase
        end
    end
endmodule