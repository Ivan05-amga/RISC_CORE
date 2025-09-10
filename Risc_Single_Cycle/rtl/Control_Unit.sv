module Control_Unit(
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic funct7_5,
    input logic zero,

    output logic PCSrc,MemWrite,ALUSrc,RegWrite,
    output logic [1:0] ResultSrc,
    output logic [2:0] ALUControl,
    output [1:0] ImmSrc
  );


  logic Branch,op5;
  logic [1:0] ALUOp;

  assign op5 = opcode[5];

  assign PCSrc = Branch & zero;

  Main_Decoder  Main_Decoder_inst (
                  .opcode(opcode),
                  .Branch(Branch),
                  .ResultSrc(ResultSrc),
                  .MemWrite(MemWrite),
                  .ALUSrc(ALUSrc),
                  .RegWrite(RegWrite),
                  .ImmSrc(ImmSrc),
                  .ALUOp(ALUOp)
                );

  Alu_Decoder  Alu_Decoder_inst (
                 .op5(op5),
                 .funct3(funct3),
                 .funct7_5(funct7_5),
                 .ALUOp(ALUOp),
                 .ALUControl(ALUControl)
               );


endmodule
