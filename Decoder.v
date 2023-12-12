module Decoder (
  input   wire  [3:0]  alu_fun,
  output  reg          Arith_EN,
  output  reg          Logic_EN,
  output  reg          CMP_EN,
  output  reg          Shift_EN
  );
  
//Decoder behaviour  
  always @ (*)
    begin
      Arith_EN = 1'b0 ;
      Logic_EN = 1'b0 ;
      CMP_EN = 1'b0 ;
      Shift_EN = 1'b0 ;
      case (alu_fun[3:2])
        2'b00 : begin
                  Arith_EN = 1'b1 ;
                 end
        2'b01 : begin
                  Logic_EN = 1'b1 ;
                 end
        2'b10 : begin
                  CMP_EN = 1'b1 ;
                 end
        2'b11 : begin 
                  Shift_EN = 1'b1 ;
                 end
        default : begin
                    Arith_EN = 1'b0 ;
                    Logic_EN = 1'b0 ;
                    CMP_EN = 1'b0 ;
                    Shift_EN = 1'b0 ;
                   end
      endcase
    end
    
endmodule