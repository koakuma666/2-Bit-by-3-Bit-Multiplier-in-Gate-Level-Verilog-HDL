/*
 * Submodule for First Row of Multiplier
 * ======================
 * By: MorseMeow
 * For:  2-Bit by 3-Bit Multiplier in Gate-Level Verilog HDL
 * Date: May 2020
 
 * Add description here
 * This is a Submodule for First Row of Multiplier 
 */

module FirstRowMultiplier (
    //declare input and output ports
    input  [1:0] min,
    input  [1:0] qin,
    input        cin,
    output       m,
    output [1:0] q,
    output       cout,
    output       s    
);
  
    // Declare several single-bit wires that we can
    // use to interconnect the gates. You can use
    // any name you like as long as it contains only
    // a-z, A-Z, underscore (_), and 0-9. Names can't
    // start with a digit.
    // Instantiate gates to calculate a and b, and do some internal connections.
    buf(m,min[0]);
    buf(q[1],qin[1]);
    buf(q[0],qin[0]);
    
    wire a,b;
    and(a,min[0],qin[1]);
    and(b,min[1],qin[0]);

//instantiates 1-Bit full adder instance
Adder1Bit MyAdder1Bit (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(cout),
    .sum(s)
);

endmodule 
