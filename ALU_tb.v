`timescale 1us/1ns

module ALU_tb ();

////////////////////////////////////////////////////////
////////////         TB Parameters         /////////////
////////////////////////////////////////////////////////
parameter  CLK_PERIOD = 10 ; 

////////////////////////////////////////////////////////
////////////          TB Signals           /////////////
////////////////////////////////////////////////////////
reg           CLK_TB       ;
reg           RST_TB       ;
reg  [7:0]    A_TB         ;
reg  [7:0]    B_TB         ;
reg  [3:0]    ALU_FUN_TB   ;
reg           EN_TB        ;
wire [15:0]   ALU_OUT_TB   ;
wire          OUT_VALID_TB ;
  
 ////////////////////////////////////////////////////////
/////////////     DUT Instantiation        /////////////
//////////////////////////////////////////////////////// 
ALU #(  .OPER_WIDTH(8),
        .OUT_WIDTH(16)
         )
DUT (
.CLK(CLK_TB),
.RST(RST_TB),
.A(A_TB), 
.B(B_TB),
.EN(EN_TB),
.ALU_FUN(ALU_FUN_TB),
.ALU_OUT(ALU_OUT_TB),
.OUT_VALID(OUT_VALID_TB)
);

////////////////////////////////////////////////////////
////////////       Clock Generator         /////////////
////////////////////////////////////////////////////////  
always  #(CLK_PERIOD/2) CLK_TB = ~ CLK_TB; 

////////////////////////////////////////////////////////
////////////            INITIAL             ////////////
////////////////////////////////////////////////////////
initial
  begin
    $dumpfile("ALU.vcd");
    $dumpvars ;
    
CLK_TB = 1'b1;
RST_TB = 1'b1  ;  // deactivated
#(15)
RST_TB = 1'b0  ;  // activated
//initial values
A_TB  = 8'd4;
B_TB  = 8'd5;
EN_TB = 1'b1 ;
ALU_FUN_TB = 4'b0000;
#CLK_PERIOD
RST_TB = 1'b1  ;  // decativated
    
    $display ("\n*** TEST CASE 1 ***"); 
    
A_TB  = 8'd250;
B_TB  = 8'd140;
EN_TB = 1'b1 ;
ALU_FUN_TB = 4'b0000;

#CLK_PERIOD
    
   if (ALU_OUT_TB == 16'd390 && OUT_VALID_TB == 1'b1)
       $display ("Addition IS PASSED") ;
   else
      begin
       $display ("Addition IS FAILED") ;
      end
    
    

    $display ("\n*** TEST CASE 2 ***") ;

A_TB  = 8'd250;
B_TB  = 8'd140;
ALU_FUN_TB = 4'b0001; 

#CLK_PERIOD
    
   if (ALU_OUT_TB == 16'd110 && OUT_VALID_TB == 1'b1)      
      $display ("Subtraction IS PASSED") ; 
   else
      $display ("Subtraction IS FAILED") ;

    
    $display ("\n*** TEST CASE 3 ***") ;

A_TB = 8'd15;
B_TB = 8'd10;
ALU_FUN_TB = 4'b0010; 

#CLK_PERIOD
    
    if (ALU_OUT_TB == 16'd150 && OUT_VALID_TB == 1'b1)         
    $display ("Multiplication IS PASSED") ; 
   else
     $display ("Multiplication IS FAILED") ;
    
    
    $display ("\n*** TEST CASE 4 ***") ;
    
A_TB = 8'd100;
B_TB = 8'd50;
ALU_FUN_TB = 4'b0011;     

#CLK_PERIOD
    
   if (ALU_OUT_TB == 16'd2 && OUT_VALID_TB == 1'b1)         
    $display ("Division IS PASSED") ; 
   else
     $display ("Division IS FAILED") ;   

    
    $display ("\n*** TEST CASE 5 ***") ;
 
A_TB = 8'b10010110;
B_TB = 8'b11110000;
ALU_FUN_TB = 4'b0100;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b10010000 && OUT_VALID_TB == 1'b1)     
    $display ("ANDING IS PASSED") ; 
   else
     $display ("ANDING IS FAILED") ;

    
    $display ("\n*** TEST CASE 6 ***") ;

A_TB = 8'b10010110;
B_TB = 8'b11110000;
ALU_FUN_TB = 4'b0101;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b11110110 && OUT_VALID_TB == 1'b1)   
    $display ("ORING IS PASSED") ; 
   else
     $display ("ORING IS FAILED") ;

    
    $display ("\n*** TEST CASE 7 ***") ;
 
A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b0110;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'hfffe && OUT_VALID_TB == 1'b1)      
    $display ("NANDING IS PASSED") ; 
   else
     $display ("NANDING IS FAILED") ;

    
    $display ("\n*** TEST CASE 8 ***") ;

A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b0111;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'hfff4 && OUT_VALID_TB == 1'b1)   
    $display ("NORING IS PASSED") ; 
   else
     $display ("NORING IS FAILED") ;

    
    $display ("\n*** TEST CASE 9 ***") ;

A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1000;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b1010 && OUT_VALID_TB == 1'b1)    
    $display ("XORING IS PASSED") ; 
   else
     $display ("XORING IS FAILED") ;


    $display ("\n*** TEST CASE 10 ***") ;

A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1001;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'hfff5 && OUT_VALID_TB == 1'b1)    
     $display ("XNORING IS PASSED") ; 
   else
     $display ("XNORING IS FAILED") ;
    
    
    $display ("\n*** TEST CASE 11 ***") ;

A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1010;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0000 && OUT_VALID_TB == 1'b1)   
    $display ("CMP_EQ IS PASSED") ; 
   else
     $display ("CMP_EQ IS FAILED") ;

    
    $display ("\n*** TEST CASE 12 ***") ;

A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1011;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0010 && OUT_VALID_TB == 1'b1) 
    $display ("CMP_GR IS PASSED") ; 
   else
     $display ("CMP_GR IS FAILED") ;

    
    $display ("\n*** TEST CASE 13 ***") ;
 
A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1100;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0000 && OUT_VALID_TB == 1'b1)  
    $display ("CMP_SM IS PASSED") ; 
   else
     $display ("CMP_SM IS FAILED") ;

    
    $display ("\n*** TEST CASE 14 ***") ;
 
A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1101;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b0100 && OUT_VALID_TB == 1'b1)    
    $display ("SFT_R IS PASSED") ; 
   else
     $display ("SFT_R  IS FAILED") ;

    
    $display ("\n*** TEST CASE 15 ***") ;
 
A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1110;  

#CLK_PERIOD
        
    if (ALU_OUT_TB == 16'b10010 && OUT_VALID_TB == 1'b1)    
    $display ("SFT_L IS PASSED") ; 
   else
     $display ("SFT_L IS FAILED") ;	 

    
    $display ("\n*** TEST CASE 16 ***") ;
 
A_TB = 8'b1001;
B_TB = 8'b0011;
ALU_FUN_TB = 4'b1111;  

#CLK_PERIOD
        
   if (ALU_OUT_TB == 16'b0000 && OUT_VALID_TB == 1'b1)    
    $display ("NO_FUN IS PASSED") ; 
   else
     $display ("NO_FUN IS FAILED") ;	 
	 
   #100 $stop;  //finished with simulation 
  end

endmodule