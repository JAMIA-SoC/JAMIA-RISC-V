module store_unit (ms_riscv32_mp_dmdata_out, ms_riscv32_mp_dmaddr_out,ms_riscv32_mp_dmwr_mask_out,ms_riscv32_mp_dmwr_req_out , funct3_in, iadder_in, rs2_in, mem_wr_req_in );

output [31:0] mem_wr_req_in,ms_riscv32_mp_dmaddr_out;
output [3:0]  ms_riscv32_mp_dmwr_mask_out;
output ms_riscv32_mp_dmwr_req_out;
input [31:0] iadder_in, rs2_in;
input [1:0] funct3_in;
input mem_wr_req_in;

always 
// naming kaise de rhe ho
// ek contribution ka kya scene h
// yaar ye bus verilog ki coding nhi lag rhi h
// yaar ye incomplete se hai ya fir phele ese pura samajhna padega or should not we connect those people on linkedin jo 6th ssem. ke bacho ne banaya tha
