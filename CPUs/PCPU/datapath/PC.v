module Pc(
    input               clk,
    input               PcWrite,
    input               reset,
    input       [31:0]  adress,
    output reg  [31:0]  PC
);
    reg [31:0] register;
    
    always@(posedge clk) begin
        if(reset == 1)
            PC <= 32'hfffffffc;
        else
            PC <= register;
    end

    always@(negedge clk)
        if(PcWrite == 1) begin
            register <= adress[31:0];
        end
        
endmodule
    
    
    