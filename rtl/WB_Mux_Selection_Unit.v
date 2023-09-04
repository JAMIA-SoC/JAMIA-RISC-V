// Code your design here
module WB_Mux_Selection_Unit ( output reg [31:0] wb_mux_out, output reg [31:0] alu_2nd_src_mux_out, input [31:0] alu_result_in,input [31:0] lu_output_in, input [31:0]imm_reg_in, input [31:0]iadder_out_reg_in, input [31:0]csr_data_in, input [31:0]pc_plus_4_reg_in, input [31:0] rs2_reg_in,input [31:0] alu_src_reg_in,input [31:0] wb_mux_sel_reg_in );
  
  parameter [2:0] WB_MUX = 3'b000;
  parameter [2:0] WB_LU = 3'b001 ;
  parameter [2:0] WB_IMM = 3'b010;
  parameter [2:0] WB_IADDER_OUT = 3'b011;
  parameter [2:0] WB_CSR = 3'b100;
  parameter [2:0] WB_PC_PLUS = 3'b101;

  
  
  
  always @(*)
    begin
      
      if (alu_src_reg_in) 
        alu_2nd_src_mux_out = rs2_reg_in;
      else 
        alu_2nd_src_mux_out = imm_reg_in;
      
      
        
    end
  always@(*) begin
    case(wb_mux_sel_reg_in)
        WB_MUX : wb_mux_out = alu_result_in ;
        WB_LU : wb_mux_out = lu_output_in;
        WB_IMM : wb_mux_out = imm_reg_in;
        WB_IADDER_OUT : wb_mux_out = 
 iadder_out_reg_in;
        WB_CSR : wb_mux_out = csr_data_in;
        WB_PC_PLUS : wb_mux_out = pc_plus_4_reg_in;
        default : wb_mux_out = alu_result_in;
    endcase
        
    end
endmodule

///////////////////////////////////////////////////////////////////////////////////// testbench /////////////////////////////////////////////////////

// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module tb_WB_Mux_Selection_Unit ;
  wire [31:0] wb_mux_out;
  wire [31:0] alu_2nd_src_mux_out;
  reg [31:0] alu_result_in = 100;
  reg [31:0] lu_output_in = 200;
  reg [31:0]imm_reg_in = 300;
  reg [31:0]iadder_out_reg_in = 400;
  reg [31:0]csr_data_in = 500;
  reg [31:0]pc_plus_4_reg_in = 600;
  reg [31:0] rs2_reg_in = 150;
  reg  alu_src_reg_in = 1;
  reg [2:0] wb_mux_sel_reg_in= 0;
  WB_Mux_Selection_Unit m1 ( wb_mux_out,
                          alu_2nd_src_mux_out,
                          alu_result_in,
                          lu_output_in,
                          imm_reg_in,
                          iadder_out_reg_in,
                          csr_data_in,
                          pc_plus_4_reg_in, 
                          rs2_reg_in,
                          alu_src_reg_in,
                          wb_mux_sel_reg_in );
  
  initial
    begin
      #5 alu_src_reg_in = 0;
      #10 wb_mux_sel_reg_in = 1;
      #15 wb_mux_sel_reg_in = 2;
      #20 wb_mux_sel_reg_in = 3;
      #25 wb_mux_sel_reg_in = 4;
      #30 wb_mux_sel_reg_in = 5;
      #35 wb_mux_sel_reg_in = 0;
    end
  
  initial
  begin 
     $dumpfile("dump.vcd");
     $dumpvars(1);
     #100 $finish;
  end
      
endmodule

//////////////////////////////////////////////////////////////////REGISTER_BLOCK//////////////////////////////////////////////////////////////////

 
  
  