/*
 * Top Level of Multiplier Test Bench
 * ======================
 * By: MorseMeow
 * For:  2-Bit by 3-Bit Multiplier in Gate-Level Verilog HDL
 * Date: May 2020
 
 * Add description here
 * This is an auto verifying test bench for the Top Level of Multiplier 
 */

// Timescale indicates unit of delays.
`timescale 1 ns/100 ps
 
// Test bench module declaration
module Multiplier_tb;

// Parameter Declarations
//
localparam NUM_CYCLES = 5000;                           //Simulate this many clock cycles. Max. 1 billion
localparam CLOCK_FREQ = 50_000_000;                     //Clock frequency (in Hz)
localparam RST_CYCLES = 2;                              //Number of cycles of reset at beginning.

//
// Test Bench Generated Signals
//
reg        clock;                                             //System clock, 50MHz
reg        reset_n;                                           //Reset, active low
reg  [1:0] m;
reg  [2:0] q;

//
// DUT Output Signals
//
wire [4:0] p;


//
// Device Under Test
//
Multiplier dut (
    .m       ( m  ),                                
    .q       ( q  ),                                
    .p       ( p  )
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

    $display("%d ns\tSimulation Started",$time);  
    $monitor("%d ns\tm=%b\tq=%b\tp=%b",$time,m,q,p);    
    
    //Initialise Value to 0.
    m  = 2'b0;  
    q  = 3'b0;     

    
    //test different values of inputs
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b0;  
    q  = 3'b0;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b0) begin
        $display("Error! Output p = %b != 0", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b01;  
    q  = 3'b000;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b0) begin
        $display("Error! Output p = %b != 00000", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b01;  
    q  = 3'b001;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b00001) begin
        $display("Error! Output p = %b != 00001", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b01;  
    q  = 3'b110;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b00110) begin
        $display("Error! Output p = %b != 00110", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b10;  
    q  = 3'b101;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b01010) begin
        $display("Error! Output p = %b != 01010", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b10;  
    q  = 3'b110;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b01100) begin
        $display("Error! Output p = %b != 01100", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b11;  
    q  = 3'b011;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b01001) begin
        $display("Error! Output p = %b != 01001", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b11;  
    q  = 3'b110;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b10010) begin
        $display("Error! Output p = %b != 10010", p);
        $stop;
    end


    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    m  = 2'b11;  
    q  = 3'b111;     
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (p != 5'b10101) begin
        $display("Error! Output p = %b != 10101", p);
        $stop;
    end
    repeat(50) @(posedge clock);         
        $display("Success!");
        $stop;
    end
 
endmodule 