module LOGIC_UNIT # ( parameter  WIDTH = 16 )
  (
  input   wire               clk,
  input   wire  [3:0]        alu_fun,
  input   wire  [WIDTH-1:0]  a,
  input   wire  [WIDTH-1:0]  b,
  input   wire               Logic_EN,
  output  reg   [WIDTH-1:0]  Logic_out,
  output  reg                Logic_flag
  );

  // Internal signal
  reg  [WIDTH-1:0]  Logic_out_comb ;
  reg               Logic_flag_comb ;
  
  // Logic_out & Logic_flag Registered
  always @ (posedge clk)
    begin
      Logic_out <= Logic_out_comb ;
      Logic_flag <= Logic_flag_comb ;
    end
    
  // Logic_out & Logic_flag combinational behaviour
  always @ (*)
    begin
      if (Logic_EN)
        begin
          Logic_out_comb = 'b0 ;
          Logic_flag_comb = 1'b1 ;
          case(alu_fun[1:0])
            2'b00: begin
                     Logic_out_comb = a & b ;
                    end
            2'b01: begin
                     Logic_out_comb = a | b ;
                    end
            2'b10: begin
                     Logic_out_comb = ~( a & b ) ;
                    end
            2'b11: begin
                     Logic_out_comb = ~( a | b ) ;
                    end
            default: begin
                       Logic_out_comb = 'b0 ;
                      end
          endcase
        end
      else
        begin
          Logic_out_comb = 'b0 ;
          Logic_flag_comb = 0'b0 ;
        end
    end
    
endmodule