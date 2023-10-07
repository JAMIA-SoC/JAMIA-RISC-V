module load_unit(
    input [31:0] dmdata_in,
    input [1:0] iadder_out_1_to_0_in,
    input load_unsigned_in,
    input [1:0] load_size_in,
    output [31:0] lu_output_out
    );
    
    // declaring reg nets for procedural block
    reg [31:0] data_out;
    
    always @ (*)
    begin
        case (load_size_in)
            2'b00:
            begin
                case (iadder_out_1_to_0_in)
                    2'b00: 
                    begin
                        if (load_unsigned_in)
                            data_out <= {24'b0, dmdata_in[7:0]};
                        else
                            data_out <= {{24{dmdata_in[7]}}, dmdata_in[7:0]};
                    end
                    2'b01: 
                    begin
                        if (load_unsigned_in)
                            data_out <= {16'b0, dmdata_in[15:8], 8'b0};
                        else
                            data_out <= {{16{dmdata_in[15]}}, dmdata_in[15:8], 8'b0};
                    end
                    2'b10: 
                    begin
                        if (load_unsigned_in)
                            data_out <= {8'b0, dmdata_in[23:16], 16'b0};
                        else
                            data_out <= {{8{dmdata_in[23]}}, dmdata_in[23:16], 16'b0};
                    end
                    2'b11: 
                    begin
                        if (load_unsigned_in)
                            data_out <= {dmdata_in[31:24], 24'b0};
                        else
                            data_out <= {dmdata_in[31:24], 24'b0};
                    end
                    default:
                    begin
                    data_out <= dmdata_in;
                    end
                endcase
            end
            2'b01:
            begin
                case (iadder_out_1_to_0_in[1])
                    1'b0:
                    begin
                        if (load_unsigned_in)
                            data_out <= {16'b0, dmdata_in[15:0]};
                        else
                            data_out <= {{16{dmdata_in[15]}}, dmdata_in[15:0]};
                    end
                    1'b1:
                    begin
                        data_out <= {dmdata_in[31:16], 16'b0};
                    end
                endcase
            end
            default:
            begin
                data_out <= dmdata_in;
            end
        endcase
    end
    
    assign lu_output_out = data_out;
endmodule