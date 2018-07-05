module rf(RA1, RA2, WA, WD, RegWrite, RD1, RD2);
    input [4:0]RA1;
    input [4:0]RA2;
    input [4:0]WA;
    input [31:0]WD;
    input RegWrite;
    output wire[31:0]RD1;
    output wire[31:0]RD2;

    reg [31:0]registers[31:0];

    assign RD1 = registers[RA1];
    assign RD2 = registers[RA2];

    integer node;
    initial
    begin
        node = 0;
        for(node=0; node<32; node=node+1)
            registers[node] = 32'h0;
    end

    always@(*)begin
        if(RegWrite && (WA!=0))
            registers[WA] = WD;
        //for(node=0; node<32; node=node+1)begin
            //$display("%x\t%x\t", node, registers[node]);
        //end
    end
endmodule

