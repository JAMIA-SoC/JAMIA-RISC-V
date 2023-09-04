module csr_file( input clk_in,
                input rst_in,
                
                
                input wr_en_in,
                input [11:0]csr_addr_in,
                input [2:0]csr_op_in,
                input [4:0]csr_uimm_in,
                input [31:0]csr_data_in ,
                input [31:0]pc_in,
                input eirq_in,
                input tirq_in,
                input sirq_in,
                input [63:0]rc_in,
                input i_or_e_in,
                input [3:0]cause_in,
                input set_cause_in,
                input set_epc_in,
                input instret_inc_in,
                input mie_clear_in,
                input mie_set_in,
                input [31:0]iadder_in,
                
                
               
                output [31:0]csr_data_out,
                output[31:0] epc_out,
                output [31:0]trap_address_out,
                output mie_out,
                output meie_out,
                output mtie_out,
                output msie_out,
                output meip_out,
                output mtip_out,
                output msip_out,
               );

  always@(*)
    begin
      if (wr_en_in )
        
    end
  

endmodule

                
                