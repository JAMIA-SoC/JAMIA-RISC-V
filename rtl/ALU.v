// Code your design here
module ALU (op_1_in, op_2_in, opcode_in, result_out);
  input [31:0] op_1_in, op_2_in;
  input [3:0] opcode_in;
  output signed [31:0] result_out;
  
  reg [6:0] funct7_in;
  reg [2:0] funct3_in;
  
  parameter [3:0] ALU_ADD = 4'b0000;
  parameter [3:0] ALU_SUB = 4'b1000;
  parameter [3:0] ALU_SLT = 4'b0010;
  parameter [3:0] ALU_SLTU = 4'b0011;
  parameter [3:0] ALU_AND = 4'b0111;
  parameter [3:0] ALU_OR = 4'b0110;
  parameter [3:0] ALU_XOR = 4'b0100;
  parameter [3:0] ALU_SLL = 4'b0001;
  parameter [3:0] ALU_SRL = 4'b0101;
  parameter [3:0] ALU_SRA = 4'b1101;
  
  always(*) begin
    opcode_in = {funct7_in[5], funct3_in};
    
    case(opcode_in)
      ALU_ADD : result_out = op_1_in - op_2_in;
      ALU_SUB : result_out =  op_1_in - op_2_in;
      ALU_SLT : result_out = 
     
   ALU_SLTU : result_out = 
   ALU_AND : result_out = &(op_1_in);
   ALU_OR : result_out = |(op_1_in);
   ALU_XOR : result_out = ^(op_1_in);
   ALU_SLL : result_out = op_1_in << 1;
   ALU_SRL : result_out = op_1_in >> 1;
   ALU_SRA : result_out = op_1_in >>> 1;
    
  
  
  
  end
  
  


endmodule
