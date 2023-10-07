module instruction_mux(
    input flush_in,
    input [31:0] instr_in,
    output [6:0] opcode_out,
    output [2:0] funct3_out,
    output [6:0] funct7_out,
    output [4:0] rs1_addr_out,
    output [4:0] rs2_addr_out,
    output [4:0] rd_addr_out,
    // output [11:0] csr_addr_out,
    output [23:0] instr_31_7_out
    );
    
    wire [31:0]flush_out = 32'h0000_0013;
    
    assign opcode_out        = (flush_in) ? flush_out[6:0] : instr_in[6:0];
    assign funct3_out        = (flush_in) ? flush_out[14:12] : instr_in[14:12];
    assign funct7_out        = (flush_in) ? flush_out[31:25] : instr_in[31:25];
    assign rs1_addr_out      = (flush_in) ? flush_out[19:15] : instr_in[19:15];
    assign rs2_addr_out      = (flush_in) ? flush_out[24:20] : instr_in[24:20];
    assign rd_addr_out       = (flush_in) ? flush_out[11:7] : instr_in[11:7];
    // assign csr_addr_out      = (flush_in) ? flush_out[31:20] : instr_in[31:20];
    assign instr_31_7_out    = (flush_in) ? flush_out[31:7] : instr_in[31:7];
   
endmodule
module instruction_mux(
    input flush_in,
    input [31:0] instr_in,
    output [6:0] opcode_out,
    output [2:0] funct3_out,
    output [6:0] funct7_out,
    output [4:0] rs1_addr_out,
    output [4:0] rs2_addr_out,
    output [4:0] rd_addr_out,
    output [11:0] csr_addr_out,
    output [23:0] instr_31_7_out
    );
    
    wire [31:0]flush_out = 32'h0000_0013;
    
    assign opcode_out        = (flush_in) ? flush_out[6:0] : instr_in[6:0];
    assign funct3_out        = (flush_in) ? flush_out[14:12] : instr_in[14:12];
    assign funct7_out        = (flush_in) ? flush_out[31:25] : instr_in[31:25];
    assign rs1_addr_out      = (flush_in) ? flush_out[19:15] : instr_in[19:15];
    assign rs2_addr_out      = (flush_in) ? flush_out[24:20] : instr_in[24:20];
    assign rd_addr_out       = (flush_in) ? flush_out[11:7] : instr_in[11:7];
    assign csr_addr_out      = (flush_in) ? flush_out[31:20] : instr_in[31:20];
    assign instr_31_7_out    = (flush_in) ? flush_out[31:7] : instr_in[31:7];
   
endmodule
