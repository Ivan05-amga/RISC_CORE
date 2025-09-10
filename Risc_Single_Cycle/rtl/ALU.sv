module ALU(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [2:0] ALU_Sel,

    output logic zero, overflow, negative, carry,
    output logic [3:0] ALU_Out
  );

  logic [32:0] result_add, result_sub;

  always_comb
  begin
    ALU_Out = 32'b0;
    zero = 1'b0;
    overflow = 1'b0;
    negative = 1'b0;
    carry = 1'b0;
    result_add = A+B;
    result_sub = A-B;

    case (ALU_Sel)
      3'b000:
      begin // ADD
        {carry, ALU_Out} = result_add[31:0];
        overflow = (A[31] == B[31]) && (ALU_Out[31] != A[31]);
      end
      3'b001:
      begin // SUB
        {carry, ALU_Out} = result_sub[31:0];
        overflow = (A[31] != B[31]) && (ALU_Out[31] != A[31]);
      end
      3'b010:
        ALU_Out = A & B;          // AND
      3'b011:
        ALU_Out = A | B;          // OR
      3'b101:
      begin // SLT
        ALU_Out = {{31{1'b0}},(result_add[31])};
      end
      default:
        ;
    endcase
    negative = ALU_Out[31];
    zero = (ALU_Out == 32'b0);
  end


endmodule
