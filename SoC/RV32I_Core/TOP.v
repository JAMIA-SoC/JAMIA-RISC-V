`timescale 1ns / 1ps

module TOP(
    input clk_in,
    input rst_in,
    input [31:0] dmdata_in,
    input [31:0] instr_in,
    output dmwr_req_out,
    output [31:0] imaddr_out,
    output [31:0] dmaddr_out,
    output [31:0] dmdata_out,
    output [3:0] dmwr_mask_out
    );
    
    // Signals for PC Mux
    wire [1:0]  pc_src;
    wire        branch_taken;
    // wire [30:0] iadder_in;
    wire [31:0] pc;
    wire        misaligned_instr;
    wire [31:0] pc_mux;
    wire [31:0] pc_plus_4;
    // wire        i_addr;
    
    // Signal for reg1
    wire [31:0] pc_out_stage1;
    
    // Signals for Immediate Generator
    wire [24:0] instr_imm_in;
    wire [2:0]  imm_type;
    wire [31:0] imm_data_out;
    
    // Signals for Immediate Adder
    wire        iadder_src;
    wire [31:0] rs1;
    wire [31:0] iadder_out;
    
    // Signals for Integer File
    wire [4:0]  rs1_adder;
    wire [4:0]  rs2_adder;
    wire [4:0]  rd_adder;
    wire        wr_enb_int_file;
    wire        int_file_reg_in;
    wire [31:0] wb_mux_out;
    wire [31:0] rs2;
    
    // Signals for wr_en_generator
    wire        flush_in;
    // wire        wr_enb_reg;
    
    // Signals for Instruction MUX
    wire [6:0]  OpCode;
    wire [6:0]  funct7;
    wire [2:0]  funct3;
    
    // Signals for Decoder
    wire [2:0]  wb_mux_sel;
    wire [3:0]  alu_opcode;
    wire [1:0]  load_size;
    wire        load_unsigned;
    wire        alu_src;
    wire        rf_wr_en;
    // wire        iadder_src;
    wire        illegal_instr;
    wire        misaligned_load;
    wire        misaligned_store;
    wire        mem_wr_req;
    
    // Signals for Machine Control
    
    // Signals for Reg block 2
    wire [2:0]  wb_mux_sel_reg;
    wire        alu_src_reg;
    wire [31:0] imm_reg_in;
    wire [31:0] iadder_out_reg;
    wire [31:0] pc_plus_4_reg;
    wire [31:0] rs2_reg;
    wire [31:0] rs1_reg;
    wire        rf_wr_en_reg;
    wire [3:0]  alu_opcode_reg;
    wire [1:0]  load_size_reg;
    wire        load_unsigned_reg;
    wire [31:0] pc_reg_2;
    wire [4:0]  rd_addr_reg;
    
    // Signals for Load Unit
    wire [31:0] lu_output;
    wire [31:0] alu_2nd_src;
    
    // Signals for Writeback mux selection unit
    
    // Signals for ALU
    wire [31:0] ALU_result;
    
    // Design Instantiation
    
    // PC Mux
    PC pc_uut(
        .rst_in(rst_in),
        .pc_src_in(pc_src),
        .pc_in(pc_out_stage1),
        .branch_taken_in(branch_taken),
        .iaddr_in(iadder_out[31:1]),
        .misaligned_instr_out(misaligned_instr),
        .pc_mux_out(pc_mux),
        .pc_plus_4_out(pc_plus_4),
        .i_addr_out(imaddr_out)
    );
    
    // Reg block 1
    reg_block_1 reg_block_1_uut (
        .clk(clk_in),
        .rst_in(rst_in),
        .pc_mux_in(pc_mux),
        .pc_out(pc_out_stage1)
    );
    
    // imm_generator
    imm_generator imm_generator_uut(
        .instr_in(instr_imm_in),
        .imm_type_in(imm_type),
        .imm_out(imm_data_out)
    );
    
    // immediate_adder
    immediate_adder immediate_adder_uut (
        .pc_in(pc_out_stage1),
        .rs1_in(rs1),
        .imm_in(imm_data_out),
        .iaddr_src_in(iadder_src),
        .iaddr_out(iadder_out)
    );
    
    // branch_unit
    branch_unit branch_unit_uut (
        .rs1_in(rs1),
        .rs2_in(rs2),
        .opcode_6_to_2_in(OpCode[6:2]),
        .funct3_in(funct3),
        .branch_taken_out(branch_taken)
    );
    
    // Integer_file
    Integer_file Integer_file_uut (
        .clk_in(clk_in),
        .rst_in(rst_in),
        .rs_1_addr_in(rs1_adder),
        .rs_2_addr_in(rs2_adder),
        .rd_addr_in(rd_adder),
        .rd_in(wb_mux_out),
        .wr_en_in(wr_enb_int_file),
        .rs_1_out(rs1),
        .rs_2_out(rs2)
    );
    
    // Write_enb_generator
    Write_enb_generator Write_enb_generator_uut (
        .flush_in(flush_in),
        .rf_wr_en_reg_in(rf_wr_en_reg),
        .wr_en_integer_file_out(wr_enb_int_file)
    );
    
    // instruction_mux
    instruction_mux instruction_mux_uut(
        .flush_in(flush_in),
        .instr_in(instr_in),
        .opcode_out(OpCode),
        .funct3_out(funct3),
        .funct7_out(funct7),
        .rs1_addr_out(rs1_adder),
        .rs2_addr_out(rs2_adder),
        .rd_addr_out(rd_adder),
        .instr_31_7_out(instr_imm_in)
    );
    
    // decoder
    decoder decoder_uut (
        .funct7_5_in(funct7[5]),
        .opcode_in(OpCode),
        .funct3_in(funct3),
        .iadder_out_1_to_0_in(iadder_out[1:0]),
        .wb_mux_sel_out(wb_mux_sel),
        .imm_type_out(imm_type),
        .mem_wr_req_out(mem_wr_req),
        .alu_opcode_out(alu_opcode),
        .load_size_out(load_size),
        .load_unsigned_out(load_unsigned),
        .alu_src_out(alu_src),
        .iadder_src_out(iadder_src),
        .rf_wr_en_out(rf_wr_en),
        .illegal_instr_out(illegal_instr),
        .misaligned_load_out(misaligned_load),
        .misaligned_store_out(misaligned_store)
    );
    
    // Machine Control
    Machine_Control Machine_Control_uut (
        .clk_in(clk_in),
        .rst_in(rst_in),
        .illegal_instr_in(illegal_instr),       
        .misaligned_load_in(misaligned_load),   
        .misaligned_instr_in(misaligned_instr), 
        .misaligned_store_in(misaligned_store), 
        .opcode_6_to_2_in(OpCode[6:2]),
        .funct3_in(funct3),
        .funct7_in(funct7),
        .rs1_adder_in(rs1_adder),
        .rs2_adder_in(rs2_adder),
        .rd_adder_in(rd_adder),
        .flush_out(flush_in),
        .pc_src_out(pc_src)
    );
    
    // reg_block_2
    reg_block_2 reg_block_2_uut (
        .clk_in(clk_in),
        .reset_in(rst_in),
        .rd_addr_in(rd_adder),
        .rs1_in(rs1),
        .rs2_in(rs2),
        .pc_in(pc_mux),
        .pc_plus_4_in(pc_plus_4),
        .branch_taken_in(branch_taken),
        .iadder_in(iadder_out),
        .alu_opcode_in(alu_opcode),
        .load_size_in(load_size),
        .load_unsigned_in(load_unsigned),
        .alu_src_in(alu_src),
        .rf_wr_en_in(rf_wr_en),
        .wb_mux_sel_in(wb_mux_sel),
        .imm_in(imm_data_out),
        
        .rd_addr_reg_out(rd_addr_reg),
        .rs1_reg_out(rs1_reg),
        .rs2_reg_out(rs2_reg),
        .pc_reg_out(pc_reg_2),
        .pc_plus_4_reg_out(pc_plus_4_reg),
        .iadder_out_reg_out(iadder_out_reg),
        .alu_opcode_reg_out(alu_opcode_reg),
        .load_size_reg_out(load_size_reg),
        .load_unsigned_reg_out(load_unsigned_reg),
        .alu_src_reg_out(alu_src_reg),
        .rf_wr_en_reg_out(rf_wr_en_reg),
        .wb_mux_sel_reg_out(wb_mux_sel_reg),
        .imm_reg_out(imm_reg_in)
    );
    
    // store_unit
    store_unit store_unit_uut (
        .funct3_in(funct3[1:0]),
        .iadder_in(iadder_out),
        .rs2_in(rs2),
        .mem_wr_req_in(mem_wr_req),
        .dmdata_out(dmdata_out),
        .dmaddr_out(dmaddr_out),
        .dmwr_mask_out(dmwr_mask_out),
        .dmwr_req_out(dmwr_req_out)
    ); 
    
    // Load Unit
    load_unit load_unit_uut (
        .dmdata_in(dmdata_in),
        .iadder_out_1_to_0_in(iadder_out[1:0]),
        .load_unsigned_in(load_unsigned),
        .load_size_in(load_size),
        .lu_output_out(lu_output)
    );
    
    // ALU
    ALU ALU_uut (
        .op_1_in(rs1_reg),
        .op_2_in(alu_2nd_src),
        .opcode_in(alu_opcode_reg),
        .result_out(ALU_result)
    );
    
    // WB_mux_selection_unit
    WB_mux_selection_unit WB_mux_selection_unit_uut (
        .alu_src_reg_in(alu_src_reg),
        .wb_mux_sel_reg_in(wb_mux_sel_reg),
        .alu_result_in(ALU_result),
        .lu_output_in(lu_output),
        .imm_reg_in(imm_reg_in),
        .iadder_out_reg(iadder_out_reg),
        .pc_plus_4_reg_in(pc_plus_4_reg),
        .rs2_reg_in(rs2_reg),
        .wb_mux_out(wb_mux_out),
        .alu_2nd_src_mux_out(alu_2nd_src)
    );
    
endmodule