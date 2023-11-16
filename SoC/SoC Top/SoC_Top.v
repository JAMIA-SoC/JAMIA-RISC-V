`timescale 1ns / 1ps
module SoC_Top(
    input clk,
    input rst
    );
    
    // Wire signals for connections
    wire [31:0] dmdata_in, instr, imaddr, dmaddr, dmdata_out;
    wire [3:0] dmwr_mask;
    wire dmwr_req;
    
    // Processor Top Instantiated
    TOP TOP_uut (
        .clk_in(clk),
        .rst_in(rst),
        .dmdata_in(dmdata_in),
        .instr_in(instr),
        .dmwr_req_out(dmwr_req),
        .imaddr_out(imaddr),
        .dmaddr_out(dmaddr),
        .dmdata_out(dmdata_out),
        .dmwr_mask_out(dmwr_mask)
    );
    
    // Icache instance
    icache icache_uut (
        .clk(clk),
        .iaddr(imaddr),
        .instr(instr)
    );

    // Dcache instance
    dcache dcache_uut (
        .clk(clk),
        .dmwr_req(dmwr_req),
        .dmwr_mask(dmwr_mask),
        .dmdata_in(dmdata_in),
        .dmdata_out(dmdata_out),
        .dmaddr(dmaddr)
    );
    
endmodule
