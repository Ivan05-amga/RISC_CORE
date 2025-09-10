module Register_File(
    input logic clk, rstn, we3,
    input logic [4:0] adress1,adress2,adress3,
    input logic  [31:0] write_data3,
    output logic [31:0] read_data1,read_data2
  );
  logic [31:0] registers [0:31];

  assign read_data1 = (adress1 == 5'h0) ? 32'h0 : registers[adress1];
  assign read_data2 = (adress2 == 5'h0) ? 32'h0 : registers[adress2];

  always_ff @(posedge clk)
  begin
    if (we3 && (adress3 != 5'h0))
    begin
        registers[adress3] <= write_data3;
    end
  end

  // Apenas para simulação
  initial
  begin

    for (integer i = 0; i < 32; i++)
    begin
      registers[i] = 32'h0;
    end
    registers[0] = 32'h0;

  end
endmodule
