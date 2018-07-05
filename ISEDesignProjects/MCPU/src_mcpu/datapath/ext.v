module ext(din, op, dout);
    input [15:0]din;
    input op;
    output reg[31:0]dout;


    always@(*)begin
        if(op==1)
            dout = (din[15]==0)?{16'b0, din}:{~16'b0, din};
        else
            dout = {16'h0, din};
    end
endmodule
