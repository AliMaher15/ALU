module ALU_TOP #( parameter  ALU_WIDTH = 16 )
( // Port Declaration
  input   wire  [ALU_WIDTH-1:0]   A,
  input   wire  [ALU_WIDTH-1:0]   B,
  input   wire  [3:0]             ALU_FUN,
  input   wire                    CLK,
  output  wire  [ALU_WIDTH-1:0]   Arith_OUT,
  output  wire  [ALU_WIDTH-1:0]   Logic_OUT,
  output  wire  [ALU_WIDTH-1:0]   CMP_OUT,
  output  wire  [ALU_WIDTH-1:0]   SHIFT_OUT,
  output  wire                    Carry_OUT,
  output  wire                    Arith_Flag,
  output  wire                    Logic_Flag,
  output  wire                    CMP_Flag,
  output  wire                    SHIFT_Flag
);
  
// Internal Connections
wire        Arith_Enable ;
wire        Logic_Enable ;
wire        CMP_Enable ;
wire        SHIFT_Enable ;

// Decoder Unit
Decoder U_decoder (
.alu_fun(ALU_FUN),
.Arith_EN(Arith_Enable),   // connected to ARITHMETIC_UNIT
.Logic_EN(Logic_Enable),   // connected to LOGIC_UNIT
.CMP_EN(CMP_Enable) ,      // connected to CMP_UNIT
.Shift_EN(SHIFT_Enable)    // connected to SHIFT_UNIT
);

// ARITHMETIC_UNIT
ARITHMETIC_UNIT #(.WIDTH(ALU_WIDTH) ) U_arithmetic_unit (
.clk(CLK),
.alu_fun(ALU_FUN),
.a(A),
.b(B),
.Arith_EN(Arith_Enable),   // connected to Decoder
.Arith_out(Arith_OUT),
.Carry_out(Carry_OUT),
.Arith_flag(Arith_Flag)
);

// LOGIC_UNIT
LOGIC_UNIT #(.WIDTH(ALU_WIDTH) ) U_logic_unit (
.clk(CLK),
.alu_fun(ALU_FUN),
.a(A),
.b(B),
.Logic_EN(Logic_Enable),   // connected to Decoder
.Logic_out(Logic_OUT),
.Logic_flag(Logic_Flag)
);

// CMP_UNIT
CMP_UNIT #(.WIDTH(ALU_WIDTH) ) U_cmp_unit (
.clk(CLK),
.alu_fun(ALU_FUN),
.a(A),
.b(B),
.CMP_EN(CMP_Enable),       // connected to Decoder
.CMP_out(CMP_OUT),
.CMP_flag(CMP_Flag)
);

// SHIFT_UNIT
SHIFT_UNIT #(.WIDTH(ALU_WIDTH) ) U_shift_unit (
.clk(CLK),
.alu_fun(ALU_FUN),
.a(A),
.b(B),
.Shift_EN(SHIFT_Enable),   // connected to Decoder
.Shift_out(SHIFT_OUT),
.Shift_flag(SHIFT_Flag)
);

endmodule