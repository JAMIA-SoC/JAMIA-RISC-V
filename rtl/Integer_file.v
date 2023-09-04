module Integer_file(
    input clk_in,
    input rst_in,
    input [4:0] rs_1_addr_in,
    input [4:0] rs_2_addr_in,
    input [4:0] rd_addr_in,
    input [31:0] rd_in,
    input wr_en_in,
    output [31:0] rs_1_out,
    output [31:0] rs_2_out
    );
    
    // Declaring Memory
    reg [31:0]memory[4:0];
    
    // Reg type nets
    reg [31:0] rs_1_out_net, rs_2_out_net;
    
    // Nets for simultaneous Read and Write
    wire simul_RW_1, simul_RW_2;
    
    // Loop Variable
    integer i;
    
    always @ (posedge clk_in)
    begin
        if (rst_in)
        begin
            for (i = 0; i < 32; i = i+1)
                begin
                memory[i] <= 32'h0000_0000;
                end
        end
    end
    
    always @ (posedge clk_in)
    begin
        rs_1_out_net <= memory[rs_1_addr_in];
        rs_2_out_net <= memory[rs_2_addr_in];
    end
    
    always @ (posedge clk_in)
    begin
        if (wr_en_in)
        memory[rd_addr_in] <= rd_in;
    end
    
    // Simultaneous Read and Write when 
    // (rs_1_addr_in == rd_addr_in)||(rs_1_addr_in == rd_addr_in)
    assign simul_RW_1 = rs_1_addr_in == rd_addr_in;
    assign simul_RW_2 = rs_2_addr_in == rd_addr_in;
    
    assign rs_1_out = (simul_RW_1) ? rd_in : rs_1_out_net;
    assign rs_2_out = (simul_RW_2) ? rd_in : rs_2_out_net;
    
endmodule