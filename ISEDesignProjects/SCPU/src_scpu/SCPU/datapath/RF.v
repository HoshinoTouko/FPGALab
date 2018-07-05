module RF(
    input           clk,
    input   [4:0]   read_address_1,
    input   [4:0]   read_address_2,
    input   [4:0]   write_address,
    input   [31:0]  write_data,
    input           reg_write,
    output  [31:0]  read_data_1,
    output  [31:0]  read_data_2
);
    reg     [31:0]  register[31:0];
    
    initial begin
        register[0] = 0;
    end
    
    always@(posedge clk) begin
        if((reg_write == 1) &&(write_address != 5'd0)) begin
            register[write_address] <= write_data;
        end
    end

    assign read_data_1 = register[read_address_1];
    assign read_data_2 = register[read_address_2];

endmodule
