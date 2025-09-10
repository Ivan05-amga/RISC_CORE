module PC(
    input logic clk, rstn,
    input logic [31:0] PC_next,
    output logic [31:0] PC
  );

  always_ff @(posedge clk)
  begin
    if (!rstn)
    begin
      PC <= 32'b0;
    end
    else
    begin
      PC <= PC_next;
    end
  end

endmodule
