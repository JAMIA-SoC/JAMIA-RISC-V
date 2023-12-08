module PC (
    input           rst_in,
    input [1:0]     pc_src_in,
    input [31:0]    pc_in,
    // input [31:0]    epc_in,
    // input [31:0]    trap_address_in,
    input           branch_taken_in,
    input [30:0]    iaddr_in,
    
    output          misaligned_instr_out,
    output [31:0]   pc_mux_out,
    output [31:0]   pc_plus_4_out,
    output [31:0]   i_addr_out
    );
    
    
    // Nets
    wire [31:0] PC_plus_4_net   = pc_in + 32'h00000004;
    wire [31:0] imm_addr_net    = {iaddr_in, 1'b0}; 
    
    // Used procedural assignments for assigning nets
    reg [31:0] next_pc;
    reg [31:0] pc_mux_out_net;
    
    // PC Mux operates in different states
    // Just declaring them for better readability
    parameter RESET_STATE       = 2'b00;
    // parameter TRAP_RETURN       = 2'b01;
    // parameter TRAP_TAKEN        = 2'b10;
    parameter OPERATING_STATE   = 2'b11;

    // MUX Branch Taken
    always @ (*)
    begin
        if (branch_taken_in)
            next_pc = imm_addr_net;
        else
            next_pc = PC_plus_4_net;
    end
    
    // MUX PC Mux Out
    always @ (*)
    begin
        case (pc_src_in)
            RESET_STATE     : pc_mux_out_net = 32'h00000000;
        //  TRAP_RETURN     : pc_mux_out_net = epc_in;
        //  TRAP_TAKEN      : pc_mux_out_net = trap_address_in;
            OPERATING_STATE : pc_mux_out_net = next_pc;
            default           pc_mux_out_net = next_pc;
        endcase
    end
    
    
    // Assignments
    assign pc_plus_4_out        = PC_plus_4_net;
    assign pc_mux_out           = pc_mux_out_net;
    
    assign i_addr_out           = (!rst_in) ? pc_mux_out_net : 32'h00000000;
    assign misaligned_instr_out = branch_taken_in & next_pc[1];

endmodule