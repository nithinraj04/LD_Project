`timescale 1 ns / 1 ns

module testbench; 

    //module LD_Project(i, s0, s1, s2, s3, i0, i1, i2, i3, i4, fgt0, fgt1, fgt2, fgt3, fgt4, 
// frt0, frt1, frt2, frt3, frt4, fgc0, fgc1, fgc2, fgc3, fgc4, frc0, frc1, frc2, frc3, frc4, fgp, frp);

    reg i, s0, s1, s2, s3;
    reg [4:0] inp;
    wire [4:0] fgt, frt, fgc, frc;
    wire fgp, frp;
    reg clk;

    LD_Project inst(clk, s0, s1, s2, s3, inp[0], inp[1], inp[2], inp[3], inp[4], fgt[0], fgt[1], fgt[2], fgt[3], fgt[4], frt[0], frt[1], frt[2], frt[3], frt[4], fgc[0], fgc[1], fgc[2], fgc[3], fgc[4], frc[0], frc[1], frc[2], frc[3], frc[4], fgp, frp);

    integer count;

    always #5 clk = ~clk;

    initial begin 

        // i = 1;
        clk = 1;
        s0 = 0; s1 = 0;
        s2 = 0; 
        inp = 5'b11111;
        #10

        // i = 0;
        // #1

        // i = 1;
        s0 = 0; s1 = 1;
        s2 = 0;
        // i0 = 1; i1 = 0; i2 = 1; i3 = 0; i4 = 1;
        inp = 5'b10101;
        #10

        // i = 0;
        // #1

        // i = 1;
        s0 = 0; s1 = 0;
        s2 = 1;
        // i0 = 0; i1 = 0; i2 = 0; i3 = 0; i4 = 0;
        inp = 5'b00000;
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

