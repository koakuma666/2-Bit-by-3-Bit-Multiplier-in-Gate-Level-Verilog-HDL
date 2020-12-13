/*
 * Top level for 2-Bit by 3-Bit Multiplier
 * ======================
 * By: MorseMeow
 * For:  2-Bit by 3-Bit Multiplier in Gate-Level Verilog HDL
 * Date: May 2020
 
 * Add description here
 * This is a Top level for 2-Bit by 3-Bit Multiplier 
 */
 
 module Multiplier (
    //declare input and output ports
    input  [1:0] m,
    input  [2:0] q,
    output [4:0] p
);

    // Declare several single-bit wires that we can
	
    wire cin0,cin1;
    buf(cin0,1'b0);
    buf(cin1,1'b0);

    and(p[0],m[0],q[0]);
    
    wire [1:0] qRowOut0;
    wire       coutRowOut0;
    wire       mRowOut0;
    
    wire [1:0] mRowIn1;
    buf(mRowIn1[1],1'b0);
    buf(mRowIn1[0],m[1]);

    
    wire       mRowOut1;
    wire       qRowOut1;
    wire       coutRowOut1;
    wire       s1;

    
    //instantiates FirstRowMultiplier instances
FirstRowMultiplier FirstRowMultiplierR (
    //declare input and output ports
    .min       ( m[1:0]      ),
    .qin       ( q[1:0]      ),
    .cin       ( cin0        ),
    .m         ( mRowOut0    ),
    .q         ( qRowOut0    ),
    .cout      ( coutRowOut0 ),
    .s         ( p[1]        )
);    



FirstRowMultiplier FirstRowMultiplierL (
    //declare input and output ports
    .min       ( mRowIn1     ),
    .qin       ( qRowOut0    ),
    .cin       ( coutRowOut0 ),
    .m         ( mRowOut1    ),
    .q         ( qRowOut1    ),
    .cout      ( coutRowOut1 ),
    .s         ( s1           )
);

    wire       qSecondRowOut0;
    wire       coutSecondRowOut0;
    wire       mSecondRowOut0;       

//instantiates RemainingRowsMultiplier instances
RemainingRowsMultiplier RemainingRowsMultiplierR (
    //declare input and output ports
    .min       ( mRowOut0 ),
    .qin       ( q[2] ),
    .cin       ( cin1 ),
    .pp        ( s1 ),
    .m         ( mSecondRowOut0 ),
    .q         ( qSecondRowOut0 ),
    .cout      ( coutSecondRowOut0 ),
    .s         ( p[2] )
);

    wire       mSecondRowOut1;
    wire       qSecondRowOut1;
    
RemainingRowsMultiplier RemainingRowsMultiplierL (
    //declare input and output ports
    .min       ( mRowOut1 ),
    .qin       ( qSecondRowOut0 ),
    .cin       ( coutSecondRowOut0 ),
    .pp        ( coutRowOut1 ),
    .m         ( mSecondRowOut1 ),
    .q         ( qSecondRowOut1 ),
    .cout      ( p[4] ),
    .s         ( p[3] )
);
endmodule 
