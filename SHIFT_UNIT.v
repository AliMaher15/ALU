module SHIFT_UNIT # ( parameter  WIDTH = 16 )
  (
  input   wire               clk,
  input   wire  [3:0]        alu_fun,
  input   wire  [WIDTH-1:0]  a,
  input   wire  [WIDTH-1:0]  b,
  input   wire               Shift_EN,
  output  reg   [WIDTH-1:0]  Shift_out,
  output  reg                Shift_flag
  );
  
  // Internal signal
  reg  [WIDTH-1:0]  Shift_out_comb ;
  reg               Shift_flag_comb ;
  
  // Shift_out & Shift_flag Registered
  always @ (posedge clk)
    begin
      Shift_out <= Shift_out_comb ;
      Shift_flag <= Shift_flag_comb ;
    end
    
  // Shift_out & Shift_flag combinational behaviour
  always @ (*)
    begin
      if (Shift_EN)
        begin
          Shift_out_comb = 'b0 ;
          Shift_flag_comb = 1'b1 ;
          case(alu_fun[1:0])
            2'b00: begin
                     Shift_out_comb = a >> 1 ;
                    end
            2'b01: begin
                     Shift_out_comb = a << 1 ;
                    end
            2'b10: begin
                     Shift_out_comb = b >> 1 ;
                    end
            2'b11: begin
                     Shift_out_comb = b << 1 ;
                    end
            default: begin
                       Shift_out_comb = 'b0 ;
                      end
          endcase
        end
      else
        begin
          Shift_out_comb = 'b0 ;
          Shift_flag_comb = 0'b0 ;
        end
    end
    
endmodule