module addAddress(
    input [31:0]add1,
    input [31:0]add2,
    output wire[31:0]addout
);
    assign addout = add1 + add2;
endmodule


