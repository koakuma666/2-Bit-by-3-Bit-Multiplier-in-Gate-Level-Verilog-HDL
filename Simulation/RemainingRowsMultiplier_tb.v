/*
 * Remaining Rows of Multiplier Test Bench
 * ======================
 * By: MorseMeow
 * For:  2-Bit by 3-Bit Multiplier in Gate-Level Verilog HDL
 * Date: May 2020
 
 * Add description here
 * This is an auto verifying test bench for the Remaining Rows of Multiplier 
 */

// Timescale indicates unit of delays.
`timescale 1 ns/100 ps
 
// Test bench module declaration
module RemainingRowsMultiplier_tb;

//
// Parameter Declarations
//
localparam NUM_CYCLES = 5000;                           //Simulate this many clock cycles. Max. 1 billion
localparam CLOCK_FREQ = 50_000_000;                     //Clock frequency (in Hz)
localparam RST_CYCLES = 2;                              //Number of cycles of reset at beginning.

//
// Test Bench Generated Signals
//
reg         clock;                                             //System clock, 50MHz
reg         reset_n;                                           //Reset, active low
reg         min;
reg         qin;
reg         cin;
reg         pp;

//
// DUT Output Signals
//
wire         cout;
wire         s;
wire         m;
wire         q;

//
// Device Under Test
//
RemainingRowsMultiplier dut (
    .min       ( min  ),                                
    .qin       ( qin  ),                                
    .cin       ( cin  ),
    .pp        ( pp   ),
    .cout      ( cout ),
    .s         ( s    ),
    .m         ( m    ),
    .q         ( q    )
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
    $monitor("%d ns\tmin=%b\tqin=%b\tpp=%bcin=%b\tm=%b\tq=%b\tcout=%b\ts=%b",$time,min,qin,pp,cin,m,q,cout,s);    
    
    //Initialise Value to 0.
    min  = 1'b0;  
    qin  = 1'b0;
    pp   = 1'b0;
    cin  = 1'b0;


    //test different values of inputs
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b0;
    qin = 1'b0;
    pp  = 1'b0;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 1'b0) begin
        $display("Error! Output q = %b != 0", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b0) begin
        $display("Error! Output s = %b != 0", s);
        $stop;
    end 

 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b0;
    qin = 1'b1;
    pp  = 1'b0;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 1'b1) begin
        $display("Error! Output q = %b != 1", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b0) begin
        $display("Error! Output s = %b != 0", s);
        $stop;
    end
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b0;
    qin = 1'b0;
    pp  = 1'b1;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 1'b0) begin
        $display("Error! Output q = %b != 0", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b1) begin
        $display("Error! Output s = %b != 1", s);
        $stop;
    end 
 
  
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b1;
    qin = 1'b0;
    pp  = 1'b1;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 1'b0) begin
        $display("Error! Output q = %b != 0", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b1) begin
        $display("Error! Output s = %b != 1", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b1;
    qin = 1'b1;
    pp  = 1'b0;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 1'b1) begin
        $display("Error! Output q = %b != 1", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b1) begin
        $display("Error! Output s = %b != 1", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b1;
    qin = 1'b1;
    pp  = 1'b1;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 1'b1) begin
        $display("Error! Output q = %b != 1", q);
        $stop;
    end
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (s != 1'b0) begin
        $display("Error! Output s = %b != 0", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b0;
    qin = 1'b0;
    pp  = 1'b0;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 1'b0) begin
        $display("Error! Output q = %b != 0", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b1) begin
        $display("Error! Output s = %b != 1", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b0;
    qin = 1'b1;
    pp  = 1'b0;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 1'b1) begin
        $display("Error! Output q = %b != 1", q);
        $stop;
    end
    if (cout != 1'b0) begin
        $display("Error! Output cout = %b != 0", cout);
        $stop;
    end
    if (s != 1'b1) begin
        $display("Error! Output s = %b != 1", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b0;
    qin = 1'b0;
    pp  = 1'b1;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 1'b0) begin
        $display("Error! Output q = %b != 0", q);
        $stop;
    end
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (s != 1'b0) begin
        $display("Error! Output s = %b != 0", s);
        $stop;
    end 
 
  
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b1;
    qin = 1'b0;
    pp  = 1'b1;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 1'b0) begin
        $display("Error! Output q = %b != 0", q);
        $stop;
    end
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (s != 1'b0) begin
        $display("Error! Output s = %b != 0", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b1;
    qin = 1'b1;
    pp  = 1'b0;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 1'b1) begin
        $display("Error! Output q = %b != 1", q);
        $stop;
    end
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (s != 1'b0) begin
        $display("Error! Output s = %b != 0", s);
        $stop;
    end 
 
 
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 1'b1;
    qin = 1'b1;
    pp  = 1'b1;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 1'b1) begin
        $display("Error! Output q = %b != 1", q);
        $stop;
    end
    if (cout != 1'b1) begin
        $display("Error! Output cout = %b != 1", cout);
        $stop;
    end
    if (s != 1'b1) begin
        $display("Error! Output s = %b != 1", s);
        $stop;
    end 

    repeat(50) @(posedge clock);         
        $display("Success!");
        $stop;
    end
 
endmodule 
