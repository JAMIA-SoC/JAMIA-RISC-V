module icache(
    input clk,
    input [31:0] iaddr,
    output reg [31:0] instr);
    
    // Memory definition
  reg [31:0] icache [0:63];
    
    // Instructions to be executed
    initial begin
      icache[0] <= 32'b00000000001001011000010100010011;
      icache[4] <= 32'b00000000001101101000011000010011;
      icache[8] <= 32'b00000000010010000000011110010011;
      icache[12] <= 32'b00000000001001010000010110010011;
      icache[16] <= 32'b00000000001101100000011010010011;
      icache[20] <= 32'b00000000010001111000100000010011;
    end
    
  always @ (posedge clk)
    begin
      instr <= icache[iaddr[5:0]];
    end

endmodule