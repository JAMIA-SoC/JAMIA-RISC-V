module icache(
    input clk,
    input [31:0] iaddr,
    output reg [31:0] instr
    );
    
    // Memory definition
    reg [31:0] icache [0:5];
    
    always @ (*)
    begin
        instr <= icache[iaddr[2:0]];
    end

endmodule