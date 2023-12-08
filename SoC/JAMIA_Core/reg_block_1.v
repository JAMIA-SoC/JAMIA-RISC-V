module reg_block_1(
    input   clk,
    input   rst_in,
    input  [31:0] pc_mux_in,
    output [31:0] pc_out 
    );
   
   // pc_out net
   reg [31:0] pc_out_net;
    
   always @ (posedge clk)
   begin
    if (rst_in)
        pc_out_net <= 32'h00000000;
    else 
        pc_out_net <= pc_mux_in;
   end
   
   assign pc_out = pc_out_net;
    
endmodule