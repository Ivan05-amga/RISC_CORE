module Main_Decoder(
    input logic [6:0] opcode,
    output logic Branch,MemWrite,ALUSrc,RegWrite,
    output logic [1:0] ResultSrc,
    output logic [1:0] ImmSrc,ALUOp
  );
  always_comb

  begin
    RegWrite  = 1'b0;
    ImmSrc    = 2'b00;
    ALUSrc    = 1'b0;
    MemWrite  = 1'b0;
    ResultSrc = 1'b00;
    Branch    = 1'b0;
    ALUOp     = 2'b00;
    case (opcode)
      7'b0000011:
      begin // R-type
        RegWrite = 1'b1;
        ImmSrc = 2'b00;
        ALUSrc = 1'b1;
        MemWrite = 1'b0;
        ResultSrc = 2'b01;
        Branch = 1'b0;
        ALUOp = 2'b00;
      end
      7'b0100011:
      begin
        RegWrite = 1'b0;
        ImmSrc = 2'b01;
        ALUSrc = 1'b1;
        MemWrite = 1'b1;
        ResultSrc = 2'b00;
        Branch = 1'b0;
        ALUOp = 2'b00;
      end
      7'b0110011:
      begin
        RegWrite = 1'b1;
        ImmSrc = 2'b00;
        ALUSrc = 1'b0;
        MemWrite = 1'b0;
        ResultSrc = 2'b00;
        Branch = 1'b0;
        ALUOp = 2'b10;
      end
      7'b1100011:
      begin
        RegWrite = 1'b0;
        ImmSrc = 2'b10;
        ALUSrc = 1'b0;
        MemWrite = 1'b0;
        ResultSrc = 2'b00;
        Branch = 1'b1;
        ALUOp = 2'b01;
      end
      7'b0010011:
      begin
        RegWrite = 1'b1;
        ImmSrc = 2'b00;
        ALUSrc = 1'b1;
        MemWrite = 1'b0;
        ResultSrc = 2'b00;
        Branch = 1'b0;
        ALUOp = 2'b10;
      end
      7'b1101111:
      begin
        RegWrite = 1'b1;
        ImmSrc = 2'b11;
        ALUSrc = 1'b1;
        MemWrite = 1'b0;
        ResultSrc = 2'b10;
        Branch = 1'b0;
        ALUOp = 2'b00;
      end
      default:
        ;
    endcase
  end
endmodule
