 // Code your design here
// Code your design here
// module WB_Mux_Selection_Unit ( output reg [31:0] wb_mux_out,
//                               output reg [31:0] alu_2nd_src_mux_out,
//                               input [31:0] alu_result_in,
//                               input [31:0] lu_output_in,
//                               input [31:0]imm_reg_in,
//                               input [31:0]iadder_out_reg_in,
//                               input [31:0]csr_data_in,
//                               input [31:0]pc_plus_4_reg_in, 
//                               input [31:0] rs2_reg_in,
//                               input alu_src_reg_in,
//                               input [2:0] wb_mux_sel_reg_in );
  
//   parameter [2:0] WB_ALU = 3'b000 ;
//   parameter [2:0] WB_LU = 3'b001;
//   parameter [2:0] WB_IMM = 3'b010 ;
//   parameter [2:0] WB_IADDER_OUT = 3'b011 ;
//   parameter [2:0] WB_CSR = 3'b100 ;
//   parameter [2:0] WB_PC_PLUS = 3'b101;
  
  
  
//   always @(*)
//     begin
      
//       if (alu_src_reg_in) 
//         alu_2nd_src_mux_out = rs2_reg_in;
//       else 
//         alu_2nd_src_mux_out = imm_reg_in;
//   end
  
//   always@(*) begin
//     case(wb_mux_sel_reg_in)
//         WB_ALU : wb_mux_out = alu_result_in ;
//         WB_LU : wb_mux_out = lu_output_in;
//         WB_IMM : wb_mux_out = imm_reg_in;
//         WB_IADDER_OUT : wb_mux_out = 
//  iadder_out_reg_in;
//         WB_CSR : wb_mux_out = csr_data_in;
//         WB_PC_PLUS : wb_mux_out = pc_plus_4_reg_in;
//         default : wb_mux_out = alu_result_in;
//     endcase
        
//     end
// endmodule

// Code your design here
// Code your design here
// module WB_Mux_Selection_Unit ( output reg [31:0] wb_mux_out,
//                               output reg [31:0] alu_2nd_src_mux_out,
//                               input [31:0] alu_result_in,
//                               input [31:0] lu_output_in,
//                               input [31:0]imm_reg_in,
//                               input [31:0]iadder_out_reg_in,
//                               input [31:0]csr_data_in,
//                               input [31:0]pc_plus_4_reg_in, 
//                               input [31:0] rs2_reg_in,
//                               input alu_src_reg_in,
//                               input [2:0] wb_mux_sel_reg_in );
  
//   parameter [2:0] WB_ALU = 3'b000 ;
//   parameter [2:0] WB_LU = 3'b001;
//   parameter [2:0] WB_IMM = 3'b010 ;
//   parameter [2:0] WB_IADDER_OUT = 3'b011 ;
//   parameter [2:0] WB_CSR = 3'b100 ;
//   parameter [2:0] WB_PC_PLUS = 3'b101;
  
  
  
//   always @(*)
//     begin
      
//       if (alu_src_reg_in) 
//         alu_2nd_src_mux_out = rs2_reg_in;
//       else 
//         alu_2nd_src_mux_out = imm_reg_in;
//   end
  
//   always@(*) begin
//     case(wb_mux_sel_reg_in)
//         WB_ALU : wb_mux_out = alu_result_in ;
//         WB_LU : wb_mux_out = lu_output_in;
//         WB_IMM : wb_mux_out = imm_reg_in;
//         WB_IADDER_OUT : wb_mux_out = 
//  iadder_out_reg_in;
//         WB_CSR : wb_mux_out = csr_data_in;
//         WB_PC_PLUS : wb_mux_out = pc_plus_4_reg_in;
//         default : wb_mux_out = alu_result_in;
//     endcase
        
//     end
// endmodule

// Code your design here
// Code your design here
// module WB_Mux_Selection_Unit ( output reg [31:0] wb_mux_out,
//                               output reg [31:0] alu_2nd_src_mux_out,
//                               input [31:0] alu_result_in,
//                               input [31:0] lu_output_in,
//                               input [31:0]imm_reg_in,
//                               input [31:0]iadder_out_reg_in,
//                               input [31:0]csr_data_in,
//                               input [31:0]pc_plus_4_reg_in, 
//                               input [31:0] rs2_reg_in,
//                               input alu_src_reg_in,
//                               input [2:0] wb_mux_sel_reg_in );
  
//   parameter [2:0] WB_ALU = 3'b000 ;
//   parameter [2:0] WB_LU = 3'b001;
//   parameter [2:0] WB_IMM = 3'b010 ;
//   parameter [2:0] WB_IADDER_OUT = 3'b011 ;
//   parameter [2:0] WB_CSR = 3'b100 ;
//   parameter [2:0] WB_PC_PLUS = 3'b101;
  
  
  
//   always @(*)
//     begin
      
//       if (alu_src_reg_in) 
//         alu_2nd_src_mux_out = rs2_reg_in;
//       else 
//         alu_2nd_src_mux_out = imm_reg_in;
//   end
  
//   always@(*) begin
//     case(wb_mux_sel_reg_in)
//         WB_ALU : wb_mux_out = alu_result_in ;
//         WB_LU : wb_mux_out = lu_output_in;
//         WB_IMM : wb_mux_out = imm_reg_in;
//         WB_IADDER_OUT : wb_mux_out = 
//  iadder_out_reg_in;
//         WB_CSR : wb_mux_out = csr_data_in;
//         WB_PC_PLUS : wb_mux_out = pc_plus_4_reg_in;
//         default : wb_mux_out = alu_result_in;
//     endcase
        
//     end
// endmodule

module reg_block2 (input clk_in,
                   input reset_in,
                   input [4:0] rd_addr_in,
                   input [11:0] csr_addr_in,
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
                   input csr_wr_en_in,
                   input rf_wr_en_in,
                   input [2:0]wb_mux_sel_in,
                   input [2:0] csr_op_in,
                   input [31:0] imm_in,
                   ////////////////
                   
                   output [4:0] rd_addr_reg_out,
                   output [11:0] csr_addr_reg_out,
                   output [31:0] rs1_reg_out,
                   output [31:0] rs2_reg_out,
                   output [31:0] pc_reg_out,
                   output [31:0] pc_plus_4_reg_out,
                   output [31:0] iadder_out_reg_out,
                   output [3:0] alu_opcode_reg_out,
                   output [1:0] load_size_reg_out,
                   output load_unsigned_reg_out,
                   output alu_src_reg_out,
                   output csr_wr_en_reg_out,
                   output rf_wr_en_reg_out,
                   output [2:0]wb_mux_sel_reg_out,
                   output [2:0] csr_op_reg_out,
                   output [31:0] imm_reg_out,
                   
                  );
  always@(posedge clk or reset)
    begin
      
      if (reset)
        begin
          rd_addr_reg_out = 0;
          csr_addr_reg_out = 0;
          rs1_reg_out = 0;
          rs2_reg_out = 0;
          pc_reg_out = 0;
          pc_plus_4_reg_out = 0;
          iadder_out_reg_out = 0;
          alu_opcode_reg_out = 0;
          load_size_reg_out = 0;
          load_unsigned_reg_out = 0;
          alu_src_reg_out = 0;
          csr_wr_en_reg_out = 0;
          rf_wr_en_reg_out = 0;
          wb_mux_sel_reg_out = 0;
          csr_op_reg_out = 0;
          imm_reg_out = 0;
        end
      else begin
        rd_addr_reg_out = rd_addr_in;
          csr_addr_reg_out =  csr_addr_in;
          rs1_reg_out =rs1_in;
          rs2_reg_out = rs2_in;
          pc_reg_out = pc_in;
          pc_plus_4_reg_out = pc_plus_4_in;
          iadder_out_reg_out =  iadder_in;
          alu_opcode_reg_out = alu_opcode_in;
          load_size_reg_out = load_size_in;
          load_unsigned_reg_out = load_unsigned_in;
          alu_src_reg_out = alu_src_in;
          csr_wr_en_reg_out = csr_wr_en_in;
          rf_wr_en_reg_out = rf_wr_en_in;
          wb_mux_sel_reg_out = wb_mux_sel_in;
          csr_op_reg_out = csr_op_in;
          imm_reg_out = imm_in;
        assign iadder_out_reg_out[0] =  (branch_taken_in) ? 0: iadder_in[0];
      end
    end
  endmodule
  
  
  
  
  
  
  
  