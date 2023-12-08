module icache(
    input clk,
    input [31:0] iaddr,
    output reg [31:0] instr);
    
    // Memory definition
  reg [31:0] icache [0:63];
    
    initial begin
      /// This has been hardcoded for initial tests
      /// Will be rectified once the process is automated
      
      icache[4] <= 32'b00000000001001011000010100010011;
      icache[8] <= 32'b00000000001101101000011000010011;
      icache[12] <= 32'b00000000010010000000011110010011;
      icache[16] <= 32'b0;
      icache[20] <= 32'b0;
      icache[24] <= 32'b00000000000101100000010101100111;
      icache[28] <= 32'b0;
      icache[32] <= 32'b0;
      icache[36] <= 32'b0;
      icache[40] <= 32'b00000000011001010010011010000011;
      icache[44] <= 32'b0;
      icache[48] <= 32'b0;
      icache[52] <= 32'b01000000110011100000011000110011;
      icache[56] <= 32'b0;
      icache[60] <= 32'b0;
      //icache[64] <= 32'b0;
      //icache[68] <= 32'b0;
      //icache[72] <= 32'b0;
    end
    
  always @ (posedge clk)
    begin
      instr <= icache[iaddr[5:0]];
    end

endmodule