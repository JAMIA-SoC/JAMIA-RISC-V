module imm_generator(
    input   [31:7]    instr_in,
    input   [2:0]     imm_type_in,
    output  [31:0]    imm_out
);

    // Declaring Nets
    reg [31:0] i_type, s_type, b_type, u_type, j_type, csr_type;
    
    reg [31:0] imm_out_net;
    
    always @ (*)
    begin
        i_type   = {{20{instr_in[31]}}, instr_in[31:20]};
        s_type   = {{20{instr_in[31]}}, instr_in[31:25], instr_in[11:7]};
        b_type   = {{20{instr_in[31]}}, instr_in[7], instr_in[30:25], instr_in[11:8], 1'b0};
        u_type   = {instr_in[31:12], 12'h000};
        j_type   = {{12{instr_in[31]}}, instr_in[19:12], instr_in[20], instr_in[30:21], 1'b0};
        // csr_type = {27'b0, instr_in[19:15]};
    end
    
    always @ (*)
    begin
        case(imm_type_in)
            3'b000: imm_out_net = 32'h00000000;
            3'b001: imm_out_net = i_type;
            3'b010: imm_out_net = s_type;
            3'b011: imm_out_net = b_type;
            3'b100: imm_out_net = u_type;
            3'b101: imm_out_net = j_type;
            // 3'b110: imm_out_net = csr_type;
            3'b111: imm_out_net = i_type;
            default imm_out_net = i_type;
        endcase
    end
    
    assign imm_out[31:0] = imm_out_net[31:0];
endmodule