module Machine_Control(
    input clk_in,
    input rst_in,
    // input eirq_in,
    // input tirq_in,
    // input sirq_in,
    input illegal_instr_in,
    input misaligned_load_in,
    input misaligned_instr_in,
    input misaligned_store_in,
    input [6:2] opcode_6_to_2_in,
    input [2:0] funct3_in,
    input [6:0] funct7_in,
    input [4:0] rs1_adder_in,
    input [4:0] rs2_adder_in,
    input [4:0] rd_adder_in,
    // input mie_in,
    // input meie_in,
    // input mtie_in,
    // input msie_in,
    // input meip_in,
    // input mtip_in,
    // input msip_in,
    // output i_or_e_out,
    // output [3:0] cause_out,
    // output instruct_inc_out,
    // output mie_clear_out,
    // output mie_set_out,
    // output misaligned_exception_out,
    // output set_epc_out,
    // output set_cause_out,
    output flush_out,
    // output trap_taken_out,
    output [1:0] pc_src_out
    );
    
    // Internal logic signals
    wire exception,
         // ip,
         // eip,
         // tip,
         // sip,
         // is_system,
         rs1_adder_zero,
         rs2_adder_zero,
         rd_zero,
         // rs2_adder_mret,
         // rs2_adder_ebreak,
         funct3_zero,
  		 funct7_zero;
         // funct7_mret,
         // csr,
         // reg_pre_instr_inc
         // ecall,
         // ebreak,
         // mret; 
         
    assign exception        = illegal_instr_in | misaligned_load_in | misaligned_store_in | misaligned_instr_in;
    // assign ip               = eip | sip | tip;
    // assign eip              = meie_in & (eirq_in | meip_in);
    // assign sip              = msie_in & (sirq_in | msip_in);
    // assign tip              = mtie_in & (tirq_in | mtip_in);
    // assign is_system        = (opcode_6_to_2_in == 5'b11100);
    assign rs1_adder_zero   = (rs1_adder_in == 5'b00000);
    assign rs2_adder_zero   = (rs2_adder_in == 5'b00000);
    assign rd_zero          = (rd_adder_in == 5'b00000);
    // assign rs2_adder_mret   = (rs2_adder_in == 5'b00010);
    // assign rs2_adder_ebreak = (rs2_adder_in == 5'b00001);
    assign funct3_zero      = (funct3_in == 3'b000);
    assign funct7_zero      = (funct7_in == 7'b0000000);
    // assign funct7_mret      = (funct7_in == 7'b0011000);
    // assign ecall            = is_system & rs1_adder_zero & rs2_adder_zero & rd_zero & funct3_zero & funct7_zero;
    // assign ebreak           = is_system & rs1_adder_zero & rd_zero & funct3_zero & funct7_zero & rs2_adder_ebreak;
    // assign mret             = is_system & rs1_adder_zero & rs2_adder_mret & rd_zero & funct3_zero & funct7_mret; 
        
    // State Machine
    // State Definition
    parameter reset         = 2'b00,
              operating     = 2'b01;
              // trap_taken    = 2'b10,
              // trap_return   = 2'b11;
    
    reg [1:0] curr_state, next_state;
    
    // State Change logic
    always @ (*)
    begin
        case(curr_state)
            reset:      next_state <= operating;
            operating:  next_state <= (reset) ? reset : operating;
            // trap_taken: next_state <= operating;
            // trap_return:next_state <= operating;
            default     next_state <= operating;
        endcase
    end 
    
    // State Transition
    always @ (posedge clk_in)
    begin
        if (rst_in)
            curr_state <= reset;
        else
            curr_state <= next_state;
    end
    
    // Outputs
    
   // pc_src_out
   reg [1:0] pc_src_net;
   // PC Values
   // BOOT = 2'b00
   // NEXT = 2'b01
   // TRAP = 2'b10
   // EPC  = 2'b11
   
   // flush_out
   reg flush_net;
   
   // instruct_inc_out
   reg instruct_inc_net;
   
   // set_epc_out, set_cause_out, mie_clear_out, mie_set_out
   reg set_epc_net, set_cause_net, mie_clear_net, mie_set_net;
   
   always @ (*)
   begin
   case (curr_state)
    reset:          begin 
                    pc_src_net <= 2'b00; 
                    flush_net <= 1'b1; 
                    // instruct_inc_net <= 1'b0;
                    // set_epc_net <= 1'b0;
                    // set_cause_net <= 1'b0;
                    // mie_clear_net <= 1'b0;
                    // mie_set_net <= 1'b0;  
                    end
    operating:      begin 
                    pc_src_net <= 2'b11; 
                    flush_net <= 1'b0; 
                    // instruct_inc_net <= 1'b1;
                    // set_epc_net <= 1'b0;
                    // set_cause_net <= 1'b0;
                    // mie_clear_net <= 1'b0;
                    // mie_set_net <= 1'b0;  
                    end
    /* trap_taken:     begin 
                    pc_src_net <= 2'b10; 
                    flush_net <= 1'b1; 
                    instruct_inc_net <= 1'b0;
                    set_epc_net <= 1'b0;
                    set_cause_net <= 1'b0;
                    mie_clear_net <= 1'b0;
                    mie_set_net <= 1'b0;  
                    end
    trap_return:    begin 
                    pc_src_net <= 2'b11; 
                    flush_net <= 1'b1; 
                    instruct_inc_net <= 1'b0;
                    set_epc_net <= 1'b0;
                    set_cause_net <= 1'b0;
                    mie_clear_net <= 1'b0;
                    mie_set_net <= 1'b0;  
                    end */
    default:        begin 
                    pc_src_net <= 2'b11; 
                    flush_net <= 1'b0; 
                    // instruct_inc_net <= 1'b1;
                    // set_epc_net <= 1'b0;
                    // set_cause_net <= 1'b0;
                    // mie_clear_net <= 1'b0;
                    // mie_set_net <= 1'b0;  
                    end
   endcase
   end
   
   assign pc_src_out = pc_src_net;
   assign flush_out = flush_net; 
   // assign instruct_inc_out = instruct_inc_net; 
   // assign set_epc_out = set_epc_net;
   // assign set_cause_out = set_cause_net;
   // assign mie_clear_out = mie_clear_net;
   // assign mie_set_out = mie_set_net;
   // assign trap_taken_out = (mie_in & ip) | ecall | ebreak;
   
   // misaligned_exception_out
//   reg misaligned_exception_net;
//   always @ (posedge clk_in)
//   begin
//    if (rst_in)
//        misaligned_exception_net <= 1'b0;
//    else
//        misaligned_exception_net <= (misaligned_load_in | misaligned_instr_in | misaligned_store_in);
//   end
   
//   assign misaligned_exception_out = misaligned_exception_net;
   
   // i_or_e_out & cause_out[3:0]
    /* reg i_or_e_net;
   reg [3:0] cause_net;
   
   always @ (posedge clk_in)
   begin
    if (curr_state == reset)
    begin
        i_or_e_net  <= 1'b0;
        cause_net   <= 4'b0;
    end
    else if (curr_state == operating)
    begin
        if (eip)
        begin
            i_or_e_net  <= 1'b1;
            cause_net   <= 4'b1011;
        end
        else if (sip)
        begin
            i_or_e_net  <= 1'b1;
            cause_net   <= 4'b0011;
        end
        else if (tip)
        begin
            i_or_e_net  <= 1'b1;
            cause_net   <= 4'b0111;
        end
        else if (illegal_instr_in)
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b0010;
        end
        else if (misaligned_instr_in)
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b0000;
        end
        else if (ecall)
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b1011;
        end
        else if (ebreak)
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b0011;
        end
        else if (misaligned_store_in)
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b0110;
        end
        else if (misaligned_load_in)
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b0100;
        end
        else
        begin
            i_or_e_net  <= 1'b0;
            cause_net   <= 4'b0000;
        end
    end
    else
    begin
       i_or_e_net  <= 1'b0;
       cause_net   <= 4'b0000; 
    end
   end
   
   assign i_or_e_out = i_or_e_net;
   assign cause_out = cause_net; */
       
endmodule