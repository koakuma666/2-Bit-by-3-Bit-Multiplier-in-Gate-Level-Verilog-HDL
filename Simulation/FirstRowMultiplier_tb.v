/*
 * First Row of Multiplier Test Bench
 * ======================
 * By: MorseMeow
 * For:  2-Bit by 3-Bit Multiplier in Gate-Level Verilog HDL
 * Date: May 2020
 
 * Add description here
 * This is an auto verifying test bench for the First Row of Multiplier 
 */

// Timescale indicates unit of delays.
`timescale 1 ns/100 ps
 
// Test bench module declaration
module FirstRowMultiplier_tb;

//
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
reg  [1:0] min;
reg  [1:0] qin;
reg        cin;

//
// DUT Output Signals
//
wire       cout;
wire       s;
wire       m;
wire [1:0] q;

//
// Device Under Test
//
FirstRowMultiplier dut (
    .min       ( min  ),                                
    .qin       ( qin  ),                                
    .cin       ( cin  ),                                
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
    $monitor("%d ns\tmin=%b\tqin=%b\tcin=%b\tm=%b\tq=%b\tcout=%b\ts=%b",$time,min,qin,cin,m,q,cout,s);    
    
    //Initialise Value to 0.
    min  = 2'b0;  
    qin  = 2'b0;     
    cin  = 1'b0;


    //test different values of inputs
    repeat(50) @(posedge clock);                        //Wait for a couple of clocks
    @(posedge clock);                                   //At the rising edge of the clock             
    min = 2'b0;
    qin = 2'b0;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 2'b00) begin
        $display("Error! Output q = %b != 00", q);
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
    min = 2'b00;
    qin = 2'b11;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
    min = 2'b10;
    qin = 2'b11;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
    min = 2'b11;
    qin = 2'b01;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b01) begin
        $display("Error! Output q = %b != 01", q);
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
    min = 2'b11;
    qin = 2'b10;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b10) begin
        $display("Error! Output q = %b != 10", q);
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
    min = 2'b01;
    qin = 2'b11;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
    min = 2'b11;
    qin = 2'b11;
    cin = 1'b0;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
    min = 2'b00;
    qin = 2'b00;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 2'b00) begin
        $display("Error! Output q = %b != 00", q);
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
    min = 2'b01;
    qin = 2'b00;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b00) begin
        $display("Error! Output q = %b != 00", q);
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
    min = 2'b10;
    qin = 2'b11;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b0) begin
        $display("Error! Output m = %b != 0", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
    min = 2'b11;
    qin = 2'b01;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b01) begin
        $display("Error! Output q = %b != 01", q);
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
    min = 2'b11;
    qin = 2'b10;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b10) begin
        $display("Error! Output q = %b != 10", q);
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
    min = 2'b01;
    qin = 2'b11;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
    min = 2'b11;
    qin = 2'b11;
    cin = 1'b1;
    
    //Now we can check the expected value    
    repeat(10) @(posedge clock);
    if (m != 1'b1) begin
        $display("Error! Output m = %b != 1", m);
        $stop;
    end
    if (q != 2'b11) begin
        $display("Error! Output q = %b != 11", q);
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
