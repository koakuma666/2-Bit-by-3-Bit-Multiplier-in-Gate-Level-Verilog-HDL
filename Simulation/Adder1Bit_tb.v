/*
 * 1-Bit Adder Test Bench
 * ======================
 * By: MorseMeow
 * For:  2-Bit by 3-Bit Multiplier in Gate-Level Verilog HDL
 * Date: May 2020
 
 * Add description here
 * This is an auto verifying test bench for a basic Full-Adder circuit 
 */

// Timescale indicates unit of delays.
`timescale 1 ns/100 ps
 
// Test bench module declaration
module Adder1Bit_tb;

//
// Parameter Declarations
//

localparam NUM_CYCLES = 5000;                           //Simulate this many clock cycles. Max. 1 billion
localparam CLOCK_FREQ = 50_000_000;                     //Clock frequency (in Hz)
localparam RST_CYCLES = 2;                              //Number of cycles of reset at beginning.

//
// Test Bench Generated Signals
//
reg  clock;                                             //System clock, 50MHz
reg  reset_n;                                           //Reset, active low
reg  a;
reg  b;
reg  cin;

//
// DUT Output Signals
//
wire cout;
wire sum;

//
// Device Under Test
//
Adder1Bit dut (
    .a         ( a    ),                                
    .b         ( b    ),                                
    .cin       ( cin  ),                                
    .cout      ( cout ),
    .sum       ( sum  )
);

//
// Reset Logic
//
initial begin
    reset_n = 1'b0;                                     //Start in reset.
    repeat(RST_CYCLES) @(posedge clock);                //Wait for a couple of clocks
    reset_n = 1'b1;                                     //Then clear the reset signal.
end

//
//Clock generator + simulation time limit.
//
initial begin
    clock = 1'b0;                                       //Initialise the clock to zero.
end

real HALF_CLOCK_PERIOD = (1000000000.0 / $itor(CLOCK_FREQ)) / 2.0;

//Now generate the clock
integer half_cycles = 0;
always begin
    //Generate the next half cycle of clock
    #(HALF_CLOCK_PERIOD);                               //Delay for half a clock period.
    clock = ~clock;                                     //Toggle the clock
    half_cycles = half_cycles + 1;                      //Increment the counter
    
    //Check if we have simulated enough half clock cycles
    if (half_cycles == (2*NUM_CYCLES)) begin 
        //Once the number of cycles has been reached
		half_cycles = 0;                                //Reset half cycles, so if we resume running with "run -all", we perform another chunk.
        $stop;                                          //Break the simulation
    end
end


//Generate our stimuli.
initial begin


    //Print to console that the simulation has started. $time is the current simulation time.
    $display("%d ns\tSimulation Started",$time);  
    $monitor("%d ns\ta=%d\tb=%d\tcin=%d\tcout=%d\tsum=%d",$time,a,b,cin,cout,sum);    
    
    //Initialise Value to 0.
    a    = 1'b0;  
    b    = 1'b0;     
    cin  = 1'b0;


    //test different values of inputs
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b0;
    b   = 1'b0 ;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (sum != 1'b0) begin
        $display("Error! Output sum = %b != 0", sum);
        $stop;
    end 
 

    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b0;
    b   = 1'b1 ;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (sum != 1'b1) begin
        $display("Error! Output sum = %b != 1", sum);
        $stop;
    end 


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b1;
    b   = 1'b0 ;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (sum != 1'b1) begin
        $display("Error! Output sum = %b != 1", sum);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b1;
    b   = 1'b1 ;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (sum != 1'b0) begin
        $display("Error! Output sum = %b != 0", sum);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b0;
    b   = 1'b0 ;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (sum != 1'b1) begin
        $display("Error! Output sum = %b != 1", sum);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b0;
    b   = 1'b1 ;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (sum != 1'b0) begin
        $display("Error! Output sum = %b != 0", sum);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b1;
    b   = 1'b0 ;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (sum != 1'b0) begin
        $display("Error! Output sum = %b != 0", sum);
        $stop;
    end

    
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    a   = 1'b1;
    b   = 1'b1 ;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (sum != 1'b1) begin
        $display("Error! Output sum = %b != 1", sum);
        $stop;
    end 
        repeat(50) @(posedge clock);         
        $display("Success!");
        $stop;
    end 
    
endmodule 
