module dcache (
    input clk,
    input dmwr_req,
    input [3:0] dmwr_mask,
    input [31:0] dmdata_in,
  output reg [31:0] dmdata_out1,
    input [31:0] dmaddr
);
    // Memory definition
    reg [31:0] dcache [0:63];
    
  always @ (posedge clk)
    begin
        if (dmwr_req)
        begin
            dcache[dmaddr[5:0]] <= dmdata_in & {{8{dmwr_mask[3]}}, {8{dmwr_mask[2]}}, {8{dmwr_mask[1]}}, {8{dmwr_mask[0]}}}; 
        end
        else
            dmdata_out1 <= dcache[dmaddr[5:0]];
    end
    
endmodule