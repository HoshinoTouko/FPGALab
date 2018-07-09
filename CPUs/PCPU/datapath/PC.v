module PC(
    input               clk,
    input               PcWrite,
    input               reset,
    input       [31:0]  address,
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
            register <= address[31:0];
        end
        
endmodule
