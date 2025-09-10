# RISC_CORE

This project implements a basic single-cycle RISC-V (RV32I) CPU in SystemVerilog.  
It includes instruction fetch, decode, execute, memory, and write-back stages, with a modular structure.

## Features
- Implements **RV32I base instructions**
- Modules:
  - Program Counter (PC)
  - Instruction Memory
  - Register File
  - Extend Unit
  - ALU
  - Data Memory
  - Control Unit (Main & ALU decoders)
- Supports **LW, SW, ADD, SUB, OR, AND, SLT, BEQ, JAL, ADDI**
## Repository Structure
- `rtl/` — SystemVerilog source files
- `tb/` — Testbenches

# Example Program: 
This is an example program that can be run on the implemented CPU. The program demonstrates a variety of instructions and control flow concepts.

L1:
    addi a0, x0, 5        # a0 = 5
    addi a1, x0, 12       # a1 = 12
    addi a2, a1, -9       # a2 = a1 - 9 = 3
    or   a3, a2, a0       # a3 = a2 | a0 = 3 | 5 = 7
    and  a4, a1, a3       # a4 = a1 & a3 = 12 & 7 = 4
    add  a4, a4, a3       # a4 = a4 + a3 = 4 + 7 = 11
    beq  a4, a2, L1       # Branch if a4 == a2 (11 == 3) -> No branch
    slt  a3, a1, a3       # a3 = (a1 < a3) ? 1 : 0 -> (12 < 7) -> a3 = 0
    beq  a3, x0, L2       # Branch if a3 == x0 (0 == 0) -> Branch to L2
    addi a4, x0, 0        # (This line is skipped)
    slt  a3, a2, a0       # (This line is skipped)
    add  a2, a3, a4       # (This line is skipped)
    sub  a2, a2, a0       # (This line is skipped)
    sw   a2, 68(a1)       # (This line is skipped)
    lw   a0, 80(x0)       # (This line is skipped)
    jal  x0, L3           # (This line is skipped)

L1: addi a0, x0, 1        # (This block is skipped)
    sw   a0, 84(x0)       # (This block is skipped)

L2: # Execution continues from here

L3: # Program ends here


# References 
- Repository: Hola39e.. MIPS_Multi_Implementation: MIPS Single Cycle/Multi Cyle/5-Stage Pipeline Verilog Implementation. GitHub. Retrieved from https://github.com/Hola39e/MIPS_Multi_Implementation

- Book: Harris, D., & Harris, S. (2021). Digital Design and Computer Architecture, RISC-V Edition. Morgan Kaufmann.
