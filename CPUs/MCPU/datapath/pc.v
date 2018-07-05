module pc(clk, pcin, inst, pcout);
    input clk;
    input [31:0]pcin;
    input inst;//控制pc写的信号量
    output [31:0]pcout;

    reg [31:0]currentPC;
    
    initial
        currentPC = 32'h0000_3000;

    always@(posedge clk)
    begin
        if(inst)begin
            currentPC = pcin;
        end
    end
    
    assign pcout =  currentPC;

endmodule