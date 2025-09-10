module Instruction_Memory(
    input logic [31:0] instruction_address,
    output logic [31:0] instruction
);

    parameter MEM_SIZE = 1023;


    logic [31:0] memory [0:MEM_SIZE-1];

    initial begin
        $readmemh("instruction_memory.mem", memory);
    end


    assign instruction = memory[instruction_address[31:2]];

    
endmodule