module ARITHMETIC_UNIT # ( parameter  WIDTH = 16 )
  (
  input   wire               clk,
  input   wire  [3:0]        alu_fun,
  input   wire  [WIDTH-1:0]  a,
  input   wire  [WIDTH-1:0]  b,
  input   wire               Arith_EN,
  output  reg   [WIDTH-1:0]  Arith_out,
  output  reg                Carry_out,
  output  reg                Arith_flag
  );

  // Internal signal
  reg  [WIDTH-1:0]  Arith_out_comb ;
  reg               Carry_out_comb ;
  reg               Arith_flag_comb ;
  
  // Arith_out, Carry_out & Arith_flag Registered
  always @ (posedge clk)
    begin
      Arith_out <= Arith_out_comb ;
      Carry_out <= Carry_out_comb ;
      Arith_flag <= Arith_flag_comb ;
    end
    
  // Arith_out, Carry_out & Arith_flag combinational behaviour
  always @ (*)
    begin
      if (Arith_EN)
        begin
          Arith_out_comb = 'b0 ;
          Carry_out_comb = 1'b0 ;
          Arith_flag_comb = 1'b1 ;
          case(alu_fun[1:0])
            2'b00: begin
                     {Carry_out_comb, Arith_out_comb} = a + b ;
                    end
            2'b01: begin
                     Arith_out_comb = a - b ;
                    end
            2'b10: begin
                     Arith_out_comb = a * b ;
                    end
            2'b11: begin
                     Arith_out_comb = a / b ;
                    end
            default: begin
                       Arith_out_comb = 'b0 ;
                       Carry_out_comb = 1'b0 ;
                      end
          endcase
        end
      else
        begin
          Arith_out_comb = 'b0 ;
          Carry_out_comb = 1'b0 ;
          Arith_flag_comb = 0'b0 ;
        end
    end
    
endmodule