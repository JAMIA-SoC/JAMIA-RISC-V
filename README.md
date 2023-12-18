# JAMIA-RISC-V

## Abstract

The aim of the project is about creating JAMIA RISC-V Core. Here JAMIA stands for **Jamia's Adaptively Modelled Implementation of Adept** RISC-V Core. It follows the RV32I instruction set, focusing on basic integer operations with 32-bit instructions. The goal is to design a processor core using Verilog, a hardware description language, and then test it using simulations and tool Vivado by Xilinx. Verification is also done by running RISC-V assembly programs which were written in RIPES Assembler.

RV32I represents a specific type of RISC-V architecture that focuses on fundamental operations. The project draws from concepts taught in a course called ECS-601 about microprocessors. The aim is to build a strong processor that aligns with the principles of RISC-V. 

<p align="center">
  
  <img src="https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/0932e856-0d09-4580-992d-5a7e6a08eabe" alt="Image" width="500" />
  
</p>


## Simulations

### 1 R-Type

R-type instructions involve operation between two operands stored in two on-chip registers. The fetched instruction should provide the address to the two operands and help the processor to decode the type of operation to be performed.

- Instruction: add x28, x12, x13
- Description: The contents of register x12 and x13 are to be added and stored back to the x28 register.

As per the ISA,
- Hex equivalent: 00d60e33
- Bin equivalent: 00000000110101100000111000110011
- Opcode: 011_0011
- funct3: 3’b000
- funct7: 7’b000_0000
- rs1_addr: 5’hC
- rs2_addr: 5’hd 
- rd_addr: 5’h1C

- The instruction has been stored at memory location: 40 (or 28H) 
- Machine cycles taken: 1
- No. of clock cycles: 3

Working:
- In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
- In next cycle, the instruction is decoded and data is read from the on-chip registers 
- In the third cycle, the addition is performed and data is sent to on-chip registers for storage.

Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/819f7aa0-7b55-4e96-8339-253b54a9d41d)


### 2 I-Type
I-type instructions involve operation between two operands, one stored in an on-chip register and the other is an immediate operand available in the instruction itself. The fetched instruction should provide the address to the operand and help the processor to decode the type of operation to be performed and the immediate value is given to the processor as a second operand.
Note: We must not ignore the fact that the immediate value can be maximum of 12-bits, as per the field size decided by the instruction format. This issue is solved later when we use AUIPC/LUI instructions. 

- Instruction: addi x10, x11, 2
- Description: The contents of register x11 and immediate value 2 are to be added and stored back to the x10 register.

As per the ISA,
- Hex equivalent: 00258513
- Bin equivalent: 00000000001001011000010100010011
- Opcode: 001_0011
- funct3: 3’b000
- funct7: 7’b000_0000
- rs1_addr: 5’hB
- rs2_addr: (ignorable)
- rd_addr: 5’hA

- The instruction has been stored at memory location: 40 (or 28H) 
- Machine cycles taken: 1
- No. of clock cycles: 3

Working:
- In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
- In next cycle, the instruction is decoded and data is read from the on-chip registers
- In the third cycle, the addition is performed and data is sent to on-chip registers for storage.

Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/b01156e9-3527-44b2-87ae-a78d027c3b3d)

### 3 S-Type
S-Type instructions in the RISC-V architecture enable the storing of register values into memory at specific offsets determined by immediate values within the instruction. These instructions facilitate the interaction between registers and memory, allowing data to be stored at calculated memory addresses. For instance, the sw (store word) instruction takes a value from a register and writes it into memory at an address derived by adding the immediate value to a base address obtained from a register. S-Type instructions are fundamental for memory manipulation within the RISC-V architecture.

- Instruction: sh x12, 0x6(x10)
- Description: The contents of register x12 are stored to data memory(dcache) via the store unit. Since this is sh instruction, only half word is loaded to the memory location [6H + [x10]], content of [x10] in this case is 2H. Hence, the destination address in this case is 8H.

As per the ISA,
- Hex equivalent: 00c51323
- Bin equivalent: 00000000110001010001001100100011
- Opcode: 010_0111
- funct3: 3’b001
- funct7: 7’b000_0000
- rs1_addr: 5’bA
- rs2_addr: 5’bC
- rd_addr: (ignorable)

- The instruction has been stored at memory location: 24 (or 18H) 
- Machine cycles taken: 2
- No. of clock cycles: 3

Working:
- In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
- In the next cycle, the instruction is decoded, and the store address is loaded via the store unit to d_cache. Corresponding mask is 4’b0011. The 32-bit value is 32’b0000_0003. As per mask 4’b0001, the value to be written to data memory is 32’b0000_0003. 
- In the third cycle, the same value is written to the d_cache.

Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/8519f227-5bcf-410f-a8b9-da5bd2085de1)

- Instruction: lw x13, 0x6(x10)
- Description: The contents of register x12 are stored to data memory(dcache) via the store unit. Since this is sh instruction, only half word is loaded to the memory location [6H + [x10]], content of [x10] in this case is 2H. Hence, the destination address in this case is 8H.

As per the ISA,
- Hex equivalent: 00652683
- Bin equivalent: 00000000011001010010011010000011
- Opcode: 000_0011
- funct3: 3’b010
- funct7: 7’b000_0000
- rs1_addr: 5’bA
- rs2_addr: (ignorable)
- rd_addr: 5’bD

- The instruction has been stored at memory location: 40 (or 28H) 
- Machine cycles taken: 2
- No. of clock cycles: 3

Working:
- In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
- In the next cycle, the instruction is decoded, and the load address is loaded via the load unit to d_cache. The 32-bit value read is 32’b0000_0003. We are reading data from the same memory location where we had written data in the previous instruction.
- In the third cycle, the same value is read to the d_cache.

Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/8207dab3-1a3c-47a5-bcb8-161e5b98d902)

### 4 B-Type
The B-Type instructions in RISC-V architecture are responsible for conditional branching, enabling the processor to change the flow of execution based on specific conditions. These instructions utilize immediate values to determine the offset for branching, allowing the program to jump to a new address if a certain condition is met. For instance, the beq (branch if equal) instruction compares two registers and, if they are equal, calculates the target address by adding the immediate offset to the current program counter. B-Type instructions are pivotal for implementing conditional logic and enabling control flow within RISC-V programs.

- Instruction: bltu x10, x12, 0x14
- Description: The control is passed to PC 0x14 if the contents of memory location [x10] is less than that of [x12] (unsigned comparison). These are conditional jump statements in the RV32I instruction set. 
- X10 = 2
- X12 = 3
Therefore, a branch is taken.
Hence PC Value changes to 18H + 14H = 2C 

As per the ISA,
- Hex equivalent: 00c56a63
- Bin equivalent: 00000000110001010110101001100011
- Opcode: 110_0011
- funct3: 3’b110
- funct7: 7’b000_0000
- rs1_addr: 5’bA
- rs2_addr: 5’bC

- The instruction has been stored at memory location: 24 (or 18H) 
- Machine cycles taken: 1
- No. of clock cycles: 3
Working:
- In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
- In the next cycle, the instruction is decoded, equality is tested and the new PC is calculated and forwarded.
- In the third cycle, the same value is observed in wb_mux out as well.
The new PC is forwarded in 2nd cycle itself to prevent pipeline stall.
Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/08d092ba-5627-40c2-b0ee-9d7c83873b86)

# 5 J-Type
The J-Type instructions in RISC-V architecture are responsible for unconditional jumping or jumping to a new address without any condition checks. They facilitate the transfer of control to a new location by using a target address derived from the immediate value within the instruction. For instance, the jal (jump and link) instruction sets the program counter to a new address formed by combining the immediate offset with the current program counter value, allowing the processor to jump to a different part of the code while also saving the address of the next instruction in a designated register (usually the link register). J-Type instructions are essential for implementing function calls, loops, and other forms of non-conditional jumps in RISC-V programs.

- Instruction: jalr x10, x12, 0x1
- Description: The control is passed to PC 0x4 unconditionally. The previous PC+4H value is stored in destination register X10. 

- X12 = 3
A branch is taken.
Hence, PC Value changes to 3H + 1H = 4H 

As per the ISA,
- Hex equivalent: 00160567
- Bin equivalent: 00000000000101100000010101100111
- Opcode: 110_0111
- funct3: 3’b000
- funct7: 7’b000_0000
- rs1_addr: 5’bC
- rs2_addr: (ignorable)
- rd_addr: 5’bA

- The instruction has been stored at memory location: 24 (or 18H) 
- Machine cycles taken: 1
- No. of clock cycles: 3

Working:
- In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
- In the next cycle, the instruction is decoded and the new PC is calculated and forwarded.
- In the third cycle, the same value is observed in wb_mux out as well.

The new PC is forwarded in 2nd cycle itself to prevent pipeline stall.

Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/56d87f3e-2d4b-4ac0-be20-7cd15f380cfc)

### 6 U-Type
The U-Type instructions in RISC-V architecture are designed for unconditional immediate operations. These instructions facilitate the addition of an immediate value to the program counter to generate a new target address for execution. The U-Type instructions allow for the direct manipulation of the program counter by using an immediate value to form a new address. For instance, the lui (load upper immediate) instruction loads a 20-bit immediate value into the upper 20 bits of a register, effectively setting the register to the immediate value shifted left by 12 bits. U-Type instructions are fundamental for immediate operations that involve setting specific upper bits of a register or generating immediate values for calculations or address formation in RISC-V programs.

- Instruction: lui x12, 0x12345 
- Description: The immediate value 0x12345 is stored in upper bytes of x12 register. The main objective of LUI instruction is to add immediate values up to 20 bits which was not possible with I-type instructions. 

As per the ISA,
- Hex equivalent: 12345637
- Bin equivalent: 00010010001101000101011000110111
- Opcode: 011_0111
- funct3: 3’b000
- funct7: 7’b000_0000
- rs1_addr: (ignorable)
- rs2_addr: (ignorable)
- rd_addr: 5’bC

- The instruction has been stored at memory location: 24 (or 18H) 
- Machine cycles taken: 1
- No. of clock cycles: 3

Working:
- In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
- In next cycle, the immediate data is sent to reg_block2 
- In the third cycle, the data is sent to on-chip registers for storage.

Tool Simulation:

![image](https://github.com/JAMIA-SoC/JAMIA-RISC-V/assets/82091082/4874e2a4-eed4-4413-af2f-dbf88f5c6e34)

