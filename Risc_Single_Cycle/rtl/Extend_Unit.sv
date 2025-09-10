module Extend_Unit(
    input  logic [31:0] instr,
    input  logic [1:0]  ImmSrc,
    output logic [31:0] imm_ext
);

  always_comb begin
    case (ImmSrc)
      2'b00: // I-type (imm[31:20])
        imm_ext = {{20{instr[31]}}, instr[31:20]};

      2'b01: // S-type (imm[31:25] and imm[11:7])
        imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};

      2'b10: // B-type (imm[31], imm[7], imm[30:25], imm[11:8], 0)
        imm_ext = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

      2'b11: // J-type (imm[31], imm[19:12], imm[20], imm[30:21], 0)
        imm_ext = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

      default: // U-type (LUI/AUIPC) just take upper 20 bits
        imm_ext = {instr[31:12], 12'b0};
    endcase
  end

endmodule



// module Extend_Unit(
//     input logic [11:0] imm_in,
//     input logic [1:0] ImmSrc,
//     output logic [31:0] imm_ext
//   );
//   always_comb
//   begin
//     case (ImmSrc)
//       2'b00: // I-type
//         imm_ext = {{20{imm_in[11]}}, imm_in[11:0]};
//       2'b01: // S-type
//         imm_ext = {{20{imm_in[11]}}, imm_in[11:0]};
//       2'b10: // B-type
//         imm_ext = {{19{imm_in[12]}}, imm_in[12], imm_in[10:5], imm_in[4:1], 1'b0};
//       default:
//         imm_ext = 32'b0;
//     endcase
//   end

// endmodule
