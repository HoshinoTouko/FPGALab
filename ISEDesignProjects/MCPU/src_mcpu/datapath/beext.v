`include "./define/be_define.v"

module beext(din, op, be);
    input [1:0]din;
    input [1:0]op;
    output reg[3:0]be;

    always@(*)
    begin
        if(op==`WORDop)begin
            be = 4'b1111;
        end
        else if(op==`HALFop)begin
            if(din[1]==1)
                be = 4'b1100;
            else
                be = 4'b0011;
        end
        else if(op==`BYTEop)begin
            case(din)
                2'b00: be = 4'b0001;
                2'b01: be = 4'b0010;
                2'b10: be = 4'b0100;
                2'b11: be = 4'b1000;
            endcase
        end
    end
endmodule