
module Im(
    input [31:0] IAddr,
    output [31:0] Iout
    );

    reg[7:0] ins[0:1023];  
	integer i;
    initial 
     begin
        $readmemb("instrs.txt", ins);   
	for (i = 0; i < 63; i = i + 1)
    begin
      if(ins[i] != 0)
        $display("ins     %d: %x", i, ins[i]);
    end 
	end

     assign Iout[7:0] = ins[IAddr+3][7:0];
	assign Iout[15:8] = ins[IAddr+2][7:0];
	assign Iout[23:16] = ins[IAddr+1][7:0];
	assign Iout[31:24] = ins[IAddr][7:0];
endmodule