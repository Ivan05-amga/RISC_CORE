module Single_Core_Top(
    input logic clk, rstn
  );

  logic [31:0] PC_next, PC,PC_plus4;
  logic [31:0] PCTarget;
  logic [31:0] instruction;
  logic [31:0] imm_ext;

  logic [31:0] read_data1, read_data2;
  logic [31:0] write_data3; // Result from ALU or Data Memory

  logic PCSrc,MemWrite,ALUSrc,RegWrite;
  logic [1:0] ResultSrc;
  logic [2:0] ALUControl;
  logic [1:0] ImmSrc;


  logic zero, overflow, negative, carry;
  logic [31:0] ALU_Out;


  logic [31:0] read_data;

  PC  PC_inst (
        .clk(clk),
        .rstn(rstn),
        .PC_next(PC_next),
        .PC(PC)
      );

  assign PC_next = (PCSrc) ? PCTarget : PC_plus4;
  assign PC_plus4 = PC + 4;

  Instruction_Memory  Instruction_Memory_inst (
                        .instruction_address(PC),
                        .instruction(instruction)
                      );

  Register_File  Register_File_inst (
                   .clk(clk),
                   .rstn(rstn),
                   .we3(RegWrite),
                   .adress1(instruction[19:15]),
                   .adress2(instruction[24:20]),
                   .adress3(instruction[11:7]),
                   .write_data3(write_data3),
                   .read_data1(read_data1),
                   .read_data2(read_data2)
                 );

  Extend_Unit  Extend_Unit_inst (
                 .instr(instruction),
                 .ImmSrc(ImmSrc),
                 .imm_ext(imm_ext)
               );

  assign PCTarget = imm_ext + PC;

  Control_Unit  Control_Unit_inst (
                  .opcode(instruction[6:0]),
                  .funct3(instruction[14:12]),
                  .funct7_5(instruction[30]),
                  .zero(zero),
                  .PCSrc(PCSrc),
                  .ResultSrc(ResultSrc),
                  .MemWrite(MemWrite),
                  .ALUSrc(ALUSrc),
                  .RegWrite(RegWrite),
                  .ALUControl(ALUControl),
                  .ImmSrc(ImmSrc)
                );


  ALU  ALU_inst (
         .A(read_data1),
         .B((ALUSrc) ? imm_ext : read_data2),
         .ALU_Sel(ALUControl),
         .zero(zero),
         .overflow(overflow),
         .negative(negative),
         .carry(carry),
         .ALU_Out(ALU_Out)
       );

  Data_Memory  Data_Memory_inst (
                 .clk(clk),
                 .we(MemWrite),
                 .adress(ALU_Out),
                 .write_data(read_data2),
                 .read_data(read_data)
               );

  always_comb
  begin
    case (ResultSrc)
      2'b00:
        write_data3 = ALU_Out;
      2'b01:
        write_data3 = read_data;
      2'b10:
        write_data3 = PC_plus4;
      default:write_data3 = 32'b0;
    endcase
  end

endmodule
