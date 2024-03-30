`timescale 1 ns / 1 ns

module testbench; 

    //module LD_Project(i, s0, s1, s2, s3, i0, i1, i2, i3, i4, fgt0, fgt1, fgt2, fgt3, fgt4, 
// frt0, frt1, frt2, frt3, frt4, fgc0, fgc1, fgc2, fgc3, fgc4, frc0, frc1, frc2, frc3, frc4, fgp, frp);

    reg i; //power
    reg s0, s1; // selector for "what to control"
    reg [4:0] inp; // input for values
    wire [4:0] temp; // temperature
    wire [4:0] cap; // capacity
    wire [4:0] fan; // fan speed
    wire [4:0] timer; // timer
    reg clk;

    LD_Project inst(clk, s0, s1, inp, temp, cap, fan, timer);

    always #5 clk = ~clk;

    initial begin 

        // i = 1;
        clk = 1;
        s0 = 0; s1 = 0;
        inp = 5'b11111;
        #10

        // i = 0;
        // #1

        // i = 1;
        s0 = 0; s1 = 1;
        // i0 = 1; i1 = 0; i2 = 1; i3 = 0; i4 = 1;
        inp = 5'b10101;
        #10

        // i = 0;
        // #1

        // i = 1;
        s0 = 1; s1 = 0;
        // i0 = 0; i1 = 0; i2 = 0; i3 = 0; i4 = 0;
        inp = 5'b01010;
        #10

        s0 = 1; s1 = 1;
        inp = 5'b10111;
        #10

        $finish();


        // clk = 0;
        // for(count = 0; count < 32; count = count + 1) 
        // begin
        //     #10 
        //     i = 1; 
        //     s0 = 1; //1 for write
        //     i0 = count[0]; 
        //     i1 = count[1]; 
        //     i2 = count[2]; 
        //     i3 = count[3]; 
        //     i4 = count[4]; 
        // end

        // i0 = 1;
        // i1 = 0;
        // i2 = 1;
        // i3 = 1;
        // i4 = 1;

        // for(count = 0; count < 32; count = count + 1) 
        // begin
        //     #10 
        //     i = 1;
        //     s0 = 0;
        //     i0 = count[0]; 
        //     i1 = count[1]; 
        //     i2 = count[2]; 
        //     i3 = count[3]; 
        //     i4 = count[4]; 
        // end

    end
endmodule

