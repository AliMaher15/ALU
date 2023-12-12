module CMP_UNIT # ( parameter  WIDTH = 16 )
  (
  input   wire               clk,
  input   wire  [3:0]        alu_fun,
  input   wire  [WIDTH-1:0]  a,
  input   wire  [WIDTH-1:0]  b,
  input   wire               CMP_EN,
  output  reg   [WIDTH-1:0]  CMP_out,
  output  reg                CMP_flag
  );

  // Internal signal
  reg  [WIDTH-1:0]  CMP_out_comb ;
  reg               CMP_flag_comb ;
  
  // CMP_out & CMP_flag Registered
  always @ (posedge clk)
    begin
      CMP_out <= CMP_out_comb ;
      CMP_flag <= CMP_flag_comb ;
    end
    
  // CMP_out & CMP_flag combinational behaviour
  always @ (*)
    begin
      if (CMP_EN)
        begin
          CMP_out_comb = 'b0 ;
          CMP_flag_comb = 1'b1 ;
          case(alu_fun[1:0])
            2'b01: begin
                     CMP_out_comb = (a==b) ? 'b1 : 'b0 ;
                    end
            2'b10: begin
                     CMP_out_comb = (a>b) ? 'b10 : 'b0 ;
                    end
            2'b11: begin
                     CMP_out_comb = (a<b) ? 'b11 : 'b0 ;
                    end
            default: begin
                       CMP_out_comb = 'b0 ;
                      end
          endcase
        end
      else
        begin
          CMP_out_comb = 'b0 ;
          CMP_flag_comb = 0'b0 ;
        end
    end
    
endmodule