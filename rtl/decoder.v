module decoder(
    input trap_taken_in,
    input funct7_5_in,
    input [6:0] opcode_in,
    input [2:0] funct3_in,
    input [1:0] iadder_out_1_to_0_in,
    output [2:0] wb_mux_sel_out,
    output [2:0] imm_type_out,
    // output [3:0] csr_op_out,
    output mem_wr_req_out,
    output [3:0] alu_opcode_out,
    output [1:0] load_size_out,
    output load_unsigned_out,
    output alu_src_out,
    output iadder_src_out,
    // output csr_wr_en_out,
    output rf_wr_en_out,
    output illegal_instr_out,
    output misaligned_load_out,
    output misaligned_store_out
    );
    
    // OpCode Decoder/Demultiplexer
    wire is_branch, 
         is_jal, 
         is_jalr, 
         is_auipc, 
         is_lui, 
         is_op, 
         is_op_imm, 
         is_load, 
         is_store, 
         is_system, 
         is_misc_mem;
         //is_csr;
         
    assign is_branch    = (opcode_in[6:2] == 5'b11000)? 1'b1 : 1'b0;
    assign is_jal       = (opcode_in[6:2] == 5'b11011)? 1'b1 : 1'b0;
    assign is_jalr      = (opcode_in[6:2] == 5'b11001)? 1'b1 : 1'b0;
    assign is_auipc     = (opcode_in[6:2] == 5'b00101)? 1'b1 : 1'b0;
    assign is_lui       = (opcode_in[6:2] == 5'b01101)? 1'b1 : 1'b0;
    assign is_op        = (opcode_in[6:2] == 5'b01100)? 1'b1 : 1'b0;
    assign is_op_imm    = (opcode_in[6:2] == 5'b00100)? 1'b1 : 1'b0;
    assign is_load      = (opcode_in[6:2] == 5'b00000)? 1'b1 : 1'b0;
    assign is_store     = (opcode_in[6:2] == 5'b01000)? 1'b1 : 1'b0;
    assign is_system    = (opcode_in[6:2] == 5'b11100)? 1'b1 : 1'b0;
    assign is_misc_mem  = (opcode_in[6:2] == 5'b00011)? 1'b1 : 1'b0;
    
    // assign is_csr       = (funct3_in[2] | funct3_in[1] | funct3_in[0]) & is_system;
    
    // funct3 decoder
    reg [7:0] funct3_decoded_net;
    always @ (*)
    begin
        case(funct3_in)
            3'b000: funct3_decoded_net = 8'b00000001;
            3'b001: funct3_decoded_net = 8'b00000010;
            3'b010: funct3_decoded_net = 8'b00000100;
            3'b011: funct3_decoded_net = 8'b00001000;
            3'b100: funct3_decoded_net = 8'b00010000;
            3'b101: funct3_decoded_net = 8'b00100000;
            3'b110: funct3_decoded_net = 8'b01000000;
            3'b111: funct3_decoded_net = 8'b10000000;
        endcase
    end
    
    // Immediate Operations nets
    wire is_addi,
         is_slti,
         is_sltiu,
         is_andi,
         is_ori,
         is_xori;
    
    assign is_addi  = funct3_decoded_net[0] & is_op_imm;
    assign is_slti  = funct3_decoded_net[2] & is_op_imm;
    assign is_sltiu = funct3_decoded_net[3] & is_op_imm;
    assign is_andi  = funct3_decoded_net[7] & is_op_imm;
    assign is_ori   = funct3_decoded_net[6] & is_op_imm;
    assign is_xori  = funct3_decoded_net[4] & is_op_imm;
    
    // is_implemented signal
    wire is_implemented;
    assign is_implemented = (is_branch| is_jal| is_jalr| is_auipc| is_lui| is_op| is_op_imm| is_load| is_store| is_system| is_misc_mem);
    
    // mal_word and mal_half signals
    wire mal_word, mal_half;
    assign mal_word = (funct3_in == 3'b010) & ~iadder_out_1_to_0_in[0];
    assign mal_half = (funct3_in == 3'b001) & ~iadder_out_1_to_0_in[0];
    
    
    // Assigning Outputs
    assign alu_opcode_out       = {(funct7_5_in & ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori)), funct3_in};
    assign load_size_out        = funct3_in[1:0];
    assign load_unsigned_out    = funct3_in[2];
    assign alu_src_out          = opcode_in[5];
    assign iadder_src_out       = is_load | is_store | is_jalr;
    // assign csr_op_out           = funct3_in[2:0];      
    assign rf_wr_en_out         = is_lui | is_auipc | is_jalr | is_jal | is_op | is_load /*| is_csr*/ | is_op_imm;
    // assign csr_wr_en_out        = is_csr;
    
    assign wb_mux_sel_out[0]    = is_load | is_auipc | is_jalr | is_jal;
    assign wb_mux_sel_out[1]    = is_lui | is_auipc;
    assign wb_mux_sel_out[2]    = /*is_csr |*/ is_jal | is_jalr;
    
    assign imm_type_out[0]       = is_op_imm | is_load | is_jal | is_jalr | is_branch;
    assign imm_type_out[1]       = is_branch | is_store ;// | is_csr;
    assign imm_type_out[2]       = is_lui | is_auipc | is_jal ; // | is_csr;
    
    assign illegal_instr_out     = ~is_implemented | ~opcode_in[1] | ~opcode_in[0];
    
    assign misaligned_load_out   = is_load & (mal_word | mal_half);
    assign misaligned_store_out  = is_store & (mal_word | mal_half);
    
    assign mem_wr_req_out        = ~(mal_word | mal_half) & is_store & trap_taken_in;
    
endmodule