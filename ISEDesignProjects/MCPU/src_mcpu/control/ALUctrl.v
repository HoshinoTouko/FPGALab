`include "./define/alu_define.v"

module aluctrl(aluop, instIn, instOut);
    input [3:0]aluop;
    input [5:0]instIn;
    output reg[4:0]instOut;

    always@(*)begin
        if(aluop==4'h0)//load or store
            instOut = `ADD;
        else if(aluop==4'h1)//beq
            instOut = `SUB;
        else if(aluop==4'h2)//R-type
        begin
            case(instIn)
                `Oadd,
                `Oaddu,
                `Ojalr: instOut = `ADD;
                `Osub,
                `Osubu: instOut = `SUB;
                `Osll,
                `Osllv: instOut = `SLL;
                `Osrl,
                `Osrlv: instOut = `SRL;
                `Osra,
                `Osrav: instOut = `SRA;
                `Oand: instOut = `AND;
                `Oor: instOut = `OR;
                `Oxor: instOut = `XOR;
                `Onor: instOut = `NOR;
                `Oslt: instOut = `SLT;
                `Osltu: instOut = `SLTU;
                //暂不支持
                `Ojalr: instOut = `ADD;
                `Ojr: instOut = `ADD; 
            endcase
        end
        //I-type
        else if(aluop==`ADDI || aluop==`ADDIU)
            instOut = `ADD;
        else if(aluop==`ANDI)
            instOut = `AND;
        else if(aluop==`ORI)
            instOut = `OR;
        else if(aluop==`XORI)
            instOut = `XOR;
        else if(aluop==`LUI)
            instOut = `LU;
        else if(aluop==`SLTI)
            instOut = `SLT;
        else if(aluop==`SLTIU)
            instOut = `SLTU;
        else if(aluop==4'hb)//bne
            instOut = `BNE;
        else if(aluop==4'hc)//bgtz
            instOut = `BGTZ;
        else if(aluop==4'hd)//blez
            instOut = `BLEZ;
        else if(aluop==4'he)//bltz
            instOut = `BLTZ;
        else if(aluop==4'hf)//bgte
            instOut = `BLTZ;

    end




endmodule