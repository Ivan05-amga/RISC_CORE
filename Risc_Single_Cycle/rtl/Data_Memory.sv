module Data_Memory(
    input logic clk,  we,
    input logic [31:0] adress,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);

    parameter MEM_SIZE = 1023;
    logic [31:0] memory [0:MEM_SIZE-1];

    assign read_data = memory[adress];
    always_ff @(posedge clk) begin
        if (we) begin
            memory[adress[31:2]] <= write_data;
        end
    end

    // For simulation purpose, initialize memory from a file

    // initial begin
    //     $readmemh("data_memory.mem", memory);
    // end

endmodule