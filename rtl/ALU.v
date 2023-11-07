// Shift and set unit are not working
// To make a new one
module ALU(
    input signed[31:0] op_1_in,
    input signed[31:0] op_2_in,
    input [3:0] opcode_in,
    output signed[31:0] result_out
); // for signed no.
    
    // Declaring reg net for storinf result in procedural block
    reg signed [31:0] data_out;
    
    always @ (*)
    begin
        case (opcode_in)
            4'b0000: data_out = op_1_in + op_2_in;
            4'b1000: data_out = op_1_in - op_2_in;
            4'b0010: data_out = (op_1_in < op_2_in) ? 1:0;
            4'b0011: data_out = ($unsigned(op_1_in) < $unsigned(op_2_in) ? 1:0;
            4'b0111: data_out = op_1_in & op_2_in;
            4'b0110: data_out = op_1_in | op_2_in;
            4'b0100: data_out = op_1_in ^ op_2_in;
            4'b0001: data_out = op_1_in << op_2_in; // logical left shiftt
            4'b0101: data_out = op_1_in >> op_2_in;
            4'b1101: data_out = op_1_in >>> op_2_in;
            default: data_out = 32'b0;
        endcase
    end
    
    assign result_out = data_out;
    
endmodule

