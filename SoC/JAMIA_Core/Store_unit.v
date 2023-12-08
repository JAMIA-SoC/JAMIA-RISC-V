module store_unit(
    input [1:0] funct3_in,      // 00- store byte; 01- store half word; 10- store word
    input [31:0] iadder_in,     // Adderess to be used   // Unaligned
    input [31:0] rs2_in,        // Data to be written    // Unaligned
    input mem_wr_req_in,
    output [31:0] dmdata_out,   // Aligned data
    output [31:0] dmaddr_out,   // Aligned address
    output [3:0] dmwr_mask_out, // Bit mask; 
    output dmwr_req_out         // Write enable signal
    );
    
    // Declaring reg type nets
    reg [31:0] data_out;
    reg [3:0] mask_out;
    
    always @ (*)
    begin
        case (funct3_in)
            2'b00:
            begin
                case (iadder_in[1:0])
                    2'b00:
                    begin
                        mask_out = {1'b0,1'b0,1'b0,mem_wr_req_in};
                        data_out = {8'b0, 8'b0, 8'b0, rs2_in[7:0]};
                    end
                    2'b01:
                    begin
                        mask_out = {1'b0,1'b0,mem_wr_req_in,1'b0};
                        data_out = {8'b0, 8'b0, rs2_in[15:8], 8'b0};
                    end
                    2'b10:
                    begin
                        mask_out = {1'b0,mem_wr_req_in,1'b0,1'b0};
                        data_out = {8'b0, rs2_in[23:16], 8'b0, 8'b0};
                    end
                    2'b11:
                    begin
                        mask_out = {mem_wr_req_in,1'b0,1'b0,1'b0};
                        data_out = {rs2_in[31:24], 8'b0, 8'b0, 8'b0};
                    end
                    default
                    begin
                        mask_out = {4{mem_wr_req_in}};
                        data_out = rs2_in;
                    end
                endcase
            end
            2'b01: 
            begin
                case (iadder_in[1])
                    1'b0: 
                    begin
                        mask_out = {2'b00, {2{mem_wr_req_in}}};
                        data_out = {16'b0, rs2_in[15:0]};
                    end
                    1'b1: 
                    begin
                        mask_out = {{2{mem_wr_req_in}}, 2'b00};
                        data_out = {rs2_in[31:16], 16'b0};
                    end
                    default:
                    begin
                        mask_out = {4{mem_wr_req_in}};
                        data_out = rs2_in;
                    end
                endcase
            end
            default: 
            begin
                mask_out = {4{mem_wr_req_in}};
                data_out = rs2_in;
            end
        endcase
    end
    
    assign dmdata_out       = data_out;
    assign dmaddr_out       = {iadder_in[31:2], 2'b00}; 
    assign dmwr_mask_out    = mask_out;
    assign dmwr_req_out     = mem_wr_req_in;
    
endmodule