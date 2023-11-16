module WB_mux_selection_unit(
    input alu_src_reg_in,
    input [2:0] wb_mux_sel_reg_in,
    input [31:0] alu_result_in,
    input [31:0] lu_output_in,
    input [31:0] imm_reg_in,
    input [31:0] iadder_out_reg,
    input [31:0] pc_plus_4_reg_in,
    input [31:0] rs2_reg_in,
    output [31:0] wb_mux_out,
    output [31:0] alu_2nd_src_mux_out
    );
    
    assign alu_2nd_src_mux_out = (alu_src_reg_in) ? rs2_reg_in : imm_reg_in;
    
    parameter [2:0] WB_MUX          = 3'b000;
    parameter [2:0] WB_LU           = 3'b001 ;
    parameter [2:0] WB_IMM          = 3'b010;
    parameter [2:0] WB_IADDER_OUT   = 3'b011;
    parameter [2:0] WB_PC_PLUS      = 3'b101;
    
    reg [31:0] data_out;
    
    always @ (*)
    begin
        case (wb_mux_sel_reg_in)
            WB_MUX:         data_out <= alu_result_in;
            WB_LU:          data_out <= lu_output_in;
            WB_IMM:         data_out <= imm_reg_in;
            WB_IADDER_OUT:  data_out <= iadder_out_reg;
            WB_PC_PLUS:     data_out <= pc_plus_4_reg_in;
            default:        data_out <= alu_result_in;
        endcase
    end
    
    assign wb_mux_out = data_out;
    
endmodule