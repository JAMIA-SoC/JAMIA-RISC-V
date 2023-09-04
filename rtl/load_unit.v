// Code your design here
module load_unit ( dmdata_in, iadder_out_1_to_0_in, load_unsigned_in, load_size_in, lu_output_out);
  input [31:0] dmdata_in;
  input [1:0] iadder_out_1_to_0_in, load_size_in;
  input load_unsigned_in;
  
  output [31:0] lu_output_out
  
  always@(*) begin
    
  load_size_in = { funct3[1], funct3[0]};
  load_unsigned_in = { funct3[2], funct3[1]};
  
    case(load_size_in)
      0 : begin
         lu_output_in[7:0] = dmdata_in[ 8*(iadder_out_1_to_0_in) : 8*((iadder_out_1_to_0_in) +1) ];
        if (load_unsigned_in == 0)
         
          begin
            lu_output_in[31:8] = 24{8*((iadder_out_1_to_0_in) +1)};
            // kiska sign bit se fill karu
          end
          end
        else if (load_unsigned_in == 1)
          begin
            lu_output_in[31:8] = 24{0};
          end
            1 : begin
              lu_output_in[15:0] = dmdata_in[ 8*(iadder_out_1_to_0_in) : 8*((iadder_out_1_to_0_in) +2) ];
        if (load_unsigned_in == 0)
         
          begin
            lu_output_in[31:15] = 16{8*((iadder_out_1_to_0_in) +2)};
            // kiska sign bit se fill karu
          end
          end
        else if (load_unsigned_in == 1)
          begin
            lu_output_in[31:16] = 12{0};
          end 
        else
          
      end
      
      // i am not sure here whether by the first byte it means 0 to 7 or 24 to 31
    endcase
  end
  
endmodule