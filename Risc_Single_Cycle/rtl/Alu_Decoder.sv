module Alu_Decoder(
    input logic      op5,
    input logic [2:0] funct3,
    input logic funct7_5,
    input logic [1:0] ALUOp,
    output logic [2:0] ALUControl
  );

  always_comb
  begin
    ALUControl = 3'b000;
    case (ALUOp)
      2'b00:
      begin
        ALUControl = 3'b000; // ADD for LW, SW
      end
      2'b01:
      begin
        ALUControl = 3'b001; // SUB for BEQ
      end
      2'b10:
      begin
        case (funct3)
          3'b000:
          begin
            if ({op5,funct7_5} == 2'b11)
            begin
              ALUControl = 3'b001; // SUB
            end
            else
            begin
              ALUControl = 3'b000; // ADD
            end
          end
          3'b010:
            ALUControl = 3'b101; // SLT
          3'b110:
            ALUControl = 3'b011; // OR
          3'b111:
            ALUControl = 3'b010; // AND
          default:
            ;
        endcase
      end
      default:
        ;
    endcase
  end

endmodule
