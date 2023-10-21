module reg_block_2(
  input clk_in,
  input reset_in,
  input [4:0] rd_addr_in,
  input [31:0] rs1_in,
  input [31:0] rs2_in,
  input [31:0] pc_in,
  input [31:0] pc_plus_4_in,
  input branch_taken_in,
  input [31:0] iadder_in,
  input [3:0] alu_opcode_in,
  input [1:0] load_size_in,
  input load_unsigned_in,
  input alu_src_in,
  input rf_wr_en_in,
  input [2:0]wb_mux_sel_in,
  input [31:0] imm_in,
  
  output reg [4:0] rd_addr_reg_out,
  output reg [31:0] rs1_reg_out,
  output reg [31:0] rs2_reg_out,
  output reg [31:0] pc_reg_out,
  output reg [31:0] pc_plus_4_reg_out,
  output reg [31:0] iadder_out_reg_out,
  output reg [3:0] alu_opcode_reg_out,
  output reg [1:0] load_size_reg_out,
  output reg load_unsigned_reg_out,
  output reg alu_src_reg_out,
  output reg rf_wr_en_reg_out,
  output reg [2:0]wb_mux_sel_reg_out,
  output reg [31:0] imm_reg_out
);
    
    always@(posedge clk_in or posedge reset_in)
    begin
      
      if (reset_in)
        begin
          rd_addr_reg_out <= 5'b0;
          rs1_reg_out <= 32'b0;
          rs2_reg_out <= 32'b0;
          pc_reg_out <= 32'b0;
          pc_plus_4_reg_out <= 32'b0;
          iadder_out_reg_out <= 32'b0;
          alu_opcode_reg_out <= 4'b0;
          load_size_reg_out <= 2'b0;
          load_unsigned_reg_out <= 0;
          alu_src_reg_out <= 0;
          rf_wr_en_reg_out <= 0;
          wb_mux_sel_reg_out <= 0;
          imm_reg_out <= 0;
        end
      else begin
          rd_addr_reg_out <= rd_addr_in;
          rs1_reg_out <= rs1_in;
          rs2_reg_out <= rs2_in;
          pc_reg_out <= pc_in;
          pc_plus_4_reg_out <= pc_plus_4_in;
          iadder_out_reg_out[31:1] <=  iadder_in[31:1];
          alu_opcode_reg_out <= alu_opcode_in;
          load_size_reg_out <= load_size_in;
          load_unsigned_reg_out <= load_unsigned_in;
          alu_src_reg_out <= alu_src_in;
          rf_wr_en_reg_out <= rf_wr_en_in;
          wb_mux_sel_reg_out <= wb_mux_sel_in;
          imm_reg_out <= imm_in;
          iadder_out_reg_out[0] <= (branch_taken_in) ? 0: iadder_in[0];
      end
    end
endmodule