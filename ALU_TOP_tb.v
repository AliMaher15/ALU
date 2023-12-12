// Timescale
`timescale 1us / 1ns

module ALU_TOP_tb();

  // parameters
  parameter  WIDTH_tb = 16 ; 
  parameter  CLK_PERIOD = 10 ; 
  parameter  duty_High = 0.6 ;
  parameter  duty_Low = 0.4 ;

  // Testbench inputs and outputs
  reg   [WIDTH_tb-1:0]     A_tb;
  reg   [WIDTH_tb-1:0]     B_tb;
  reg   [3:0]              ALU_FUN_tb;
  reg                      CLK_tb;
  wire  [WIDTH_tb-1:0]     Arith_OUT_tb;
  wire                     Carry_OUT_tb;
  wire  [WIDTH_tb-1:0]     Logic_OUT_tb;
  wire  [WIDTH_tb-1:0]     CMP_OUT_tb;
  wire  [WIDTH_tb-1:0]     SHIFT_OUT_tb;
  wire                     Arith_Flag_tb;
  wire                     Logic_Flag_tb;
  wire                     CMP_Flag_tb;
  wire                     SHIFT_Flag_tb;
  
  //concatenate flags
  wire [3:0] Flags ;

  // Grouping flags signals
  assign Flags = {Arith_Flag_tb, Logic_Flag_tb , CMP_Flag_tb , SHIFT_Flag_tb};
  
  // Clock Generator ( 100kHz, 10us )
  always
    begin
      // assuming clk start initially at low
      #(CLK_PERIOD * duty_Low)
      CLK_tb = !CLK_tb ;        // clk turns to high
      #(CLK_PERIOD * duty_High)
      CLK_tb = !CLK_tb ;        // clk turns to low
    end
      
  
  // Instaniate design instance
  ALU_TOP #(.ALU_WIDTH(WIDTH_tb) ) DUT (
    .A(A_tb),
    .B(B_tb),
    .ALU_FUN(ALU_FUN_tb),
    .CLK(CLK_tb),
    .Arith_OUT(Arith_OUT_tb),
    .Carry_OUT(Carry_OUT_tb),
    .Logic_OUT(Logic_OUT_tb),
    .CMP_OUT(CMP_OUT_tb),
    .SHIFT_OUT(SHIFT_OUT_tb),
    .Arith_Flag(Arith_Flag_tb),
    .Logic_Flag(Logic_Flag_tb),
    .CMP_Flag(CMP_Flag_tb),
    .SHIFT_Flag(SHIFT_Flag_tb)
  );

  // Initial Block
  initial
    begin
      $dumpfile("ALU_TOP.vcd");
      $dumpvars;
      
  // Initial values
  CLK_tb = 1'b0 ;

      $display("**** TEST CASE 1 ****");
  
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b0000 ;
  
  #CLK_PERIOD
    
    if (Arith_OUT_tb == 'd15 && Carry_OUT_tb == 1'b0 && Flags == 4'b1000)
        $display("Addition IS PASSED");
    else
        begin
          $display("Addition IS FAILED");
          $display("Arith_OUT = %d", Arith_OUT_tb) ;
        end
    
      $display("**** TEST CASE 2 ****");
  // in case of 16-bit ALU
  A_tb = 'd32780 ;
  B_tb = 'd32770 ;
  ALU_FUN_tb = 4'b0000 ;
  
  #CLK_PERIOD
    
    if (Arith_OUT_tb == 'd14 && Carry_OUT_tb == 1'b1 && Flags == 4'b1000)
        $display("Addition with Carry IS PASSED");
    else
        begin
          $display("Addition with Carry IS FAILED");
          $display("Arith_OUT = %d", Arith_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 3 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b0001 ;
  
  #CLK_PERIOD
    
    if (Arith_OUT_tb == 'd5 && Flags == 4'b1000)
        $display("Subtraction IS PASSED");
    else
        begin
          $display("Subtraction IS FAILED");
          $display("Arith_OUT = %d", Arith_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 4 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b0010 ;
  
    #CLK_PERIOD
    
    if (Arith_OUT_tb == 'd50 && Flags == 4'b1000)
        $display("Multiplication IS PASSED");
    else
        begin
          $display("Multiplication IS FAILED");
          $display("Arith_OUT = %d", Arith_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 5 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b0011 ;
  
    #CLK_PERIOD
    
    if (Arith_OUT_tb == 'd2 && Flags == 4'b1000)
        $display("Division IS PASSED");
    else
        begin
          $display("Division IS FAILED");
          $display("Arith_OUT = %d", Arith_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 6 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b0100 ;
  
    #CLK_PERIOD
    
    if (Logic_OUT_tb == 'b0001 && Flags == 4'b0100)
        $display("AND IS PASSED");
    else
        begin
          $display("AND IS FAILED");
          $display("Logic_OUT = %b", Logic_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 7 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b0101 ;
  
    #CLK_PERIOD
    
    if (Logic_OUT_tb == 'b1011 && Flags == 4'b0100)
        $display("OR IS PASSED");
    else
        begin
          $display("OR IS FAILED");
          $display("Logic_OUT = %b", Logic_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 8 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b0110 ;
  
    #CLK_PERIOD
    
    if (Logic_OUT_tb == 'hfffe && Flags == 4'b0100)
        $display("NAND IS PASSED");
    else
        begin
          $display("NAND IS FAILED");
          $display("Logic_OUT = %b", Logic_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 9 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b0111 ;
  
    #CLK_PERIOD
    
    if (Logic_OUT_tb == 'hfff4 && Flags == 4'b0100)
        $display("NOR IS PASSED");
    else
        begin
          $display("NOR IS FAILED");
          $display("Logic_OUT = %b", Logic_OUT_tb) ;
        end
    
      $display ("*** TEST CASE 10 ***");
      
  A_tb = 'd20 ;
  B_tb = 'd15 ;
  ALU_FUN_tb = 4'b1000 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd0 && Flags == 4'b0010)
        $display("NOP IS PASSED");
    else
        begin
          $display("NOP IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 11 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd10 ;
  ALU_FUN_tb = 4'b1001 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd1 && Flags == 4'b0010)
        $display("CMP_EQ success IS PASSED");
    else
        begin
          $display("CMP_EQ success IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 12 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b1001 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd0 && Flags == 4'b0010)
        $display("CMP_EQ fail IS PASSED");
    else
        begin
          $display("CMP_EQ fail IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 13 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b1010 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd2 && Flags == 4'b0010)
        $display("CMP_GR success IS PASSED");
    else
        begin
          $display("CMP_GR success IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 14 ***");
      
  A_tb = 'd5 ;
  B_tb = 'd10 ;
  ALU_FUN_tb = 4'b1010 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd0 && Flags == 4'b0010)
        $display("CMP_GR fail IS PASSED");
    else
        begin
          $display("CMP_GR fail IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 15 ***");
      
  A_tb = 'd5 ;
  B_tb = 'd10 ;
  ALU_FUN_tb = 4'b1011 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd3 && Flags == 4'b0010)
        $display("CMP_SM success IS PASSED");
    else
        begin
          $display("CMP_SM success IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 16 ***");
      
  A_tb = 'd10 ;
  B_tb = 'd5 ;
  ALU_FUN_tb = 4'b1011 ;
  
    #CLK_PERIOD
    
    if (CMP_OUT_tb == 'd0 && Flags == 4'b0010)
        $display("CMP_SM fail IS PASSED");
    else
        begin
          $display("CMP_SM fail IS FAILED");
          $display("CMP_OUT = %d", CMP_OUT_tb) ;
        end

      $display ("*** TEST CASE 17 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b1100 ;
  
    #CLK_PERIOD
    
    if (SHIFT_OUT_tb == 'b0100 && Flags == 4'b0001)
        $display("SFT_R of A IS PASSED");
    else
        begin
          $display("SFT_R of A IS FAILED");
          $display("SHIFT_OUT = %b", SHIFT_OUT_tb) ;
        end

      $display ("*** TEST CASE 18 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b1101 ;
  
    #CLK_PERIOD
    
    if (SHIFT_OUT_tb == 'b10010 && Flags == 4'b0001)
        $display("SFT_L of A IS PASSED");
    else
        begin
          $display("SFT_L of A IS FAILED");
          $display("SHIFT_OUT = %b", SHIFT_OUT_tb) ;
        end

      $display ("*** TEST CASE 19 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b1110 ;
  
    #CLK_PERIOD
    
    if (SHIFT_OUT_tb == 'b0001 && Flags == 4'b0001)
        $display("SFT_R of B IS PASSED");
    else
        begin
          $display("SFT_R of B IS FAILED");
          $display("SHIFT_OUT = %b", SHIFT_OUT_tb) ;
        end

      $display ("*** TEST CASE 20 ***");
      
  A_tb = 'b1001 ;
  B_tb = 'b0011 ;
  ALU_FUN_tb = 4'b1111 ;
  
    #CLK_PERIOD
    
    if (SHIFT_OUT_tb == 'b00110 && Flags == 4'b0001)
        $display("SFT_L of B IS PASSED");
    else
        begin
          $display("SFT_L of B IS FAILED");
          $display("SHIFT_OUT = %b", SHIFT_OUT_tb) ;
        end

    #100  $finish;  //finished with simulation 

    end

endmodule