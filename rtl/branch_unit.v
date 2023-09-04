module branch_unit(
    input [31:0] rs1_in,
    input [31:0] rs2_in,
    input [4:0] opcode_6_to_2_in,
    input [2:0] funct3_in,
    output branch_taken_out
    );
    
    // Cases when its branch operation(Conditional Jumps)
    // Net to store if branch is supposed to be taken
    
    reg branch_taken_net1;
    
    always @(*)
    begin
        if (opcode_6_to_2_in == 5'b11011)       //opcode for Jump Instructions (Unconditional jump)
        begin
            branch_taken_net1 = 1'b1;
        end
        else if (opcode_6_to_2_in == 5'b11000)  //opcode for Branch Instructions (Unconditional jump)
        begin
            case (funct3_in)
                3'b000: branch_taken_net1 = (rs1_in == rs2_in) ? 1'b1 : 1'b0;
                3'b001: branch_taken_net1 = (rs1_in != rs2_in) ? 1'b1 : 1'b0;
                3'b010: branch_taken_net1 = 1'b0;
                3'b011: branch_taken_net1 = 1'b0;
                3'b100: branch_taken_net1 = (rs1_in < rs2_in) ? 1'b1 : 1'b0;
                3'b101: branch_taken_net1 = (rs1_in >= rs2_in) ? 1'b1 : 1'b0;
                3'b110: branch_taken_net1 = ((rs1_in < rs2_in)  | (rs1_in[31] & ~rs2_in[31])) ? 1'b1 : 1'b0;
                3'b111: branch_taken_net1 = ((rs1_in >= rs2_in) | (rs1_in[31] & ~rs2_in[31])) ? 1'b1 : 1'b0;
                default branch_taken_net1 = 1'b0;
            endcase
        end
        else
        begin
            branch_taken_net1 = 1'b0;
        end    
    end 
    
    assign branch_taken_out = branch_taken_net1;
endmodule
