`timescale 1 ns / 1 ns

module testbench; 
    reg s0, s1; // selector for "what device to control"
    reg s2; // Device number
    reg s3, s4; // What to control in device
    reg s5; // fridge/freezer (specific to fridge)

    reg [4:0] inp; // input for values
    wire [4:0] fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2;
    wire ice1, ice2;
    wire [4:0] actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2;

    reg clk;

    LD_Project inst(clk, s0, s1, s2, s3, s4, s5, inp, fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2, ice1, ice2, actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2);

    always #5 clk = ~clk;

    initial begin 

        clk = 1;
        
        // Initialize icemakers to 0
        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 1; s4 = 0;
        s5 = 1'bx;
        inp = 5'b00000;
        #10;
        s0 = 0; s1 = 0;
        s2 = 1;
        s3 = 1; s4 = 0;
        s5 = 1'bx;
        inp = 5'b00000;
        #10;

        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 0; s4 = 0;
        s5 = 0;
        inp = 5'b10101;
        #10

        // Test Case 1
        #10;
        s0 = 0; s1 = 1;
        s2 = 1;
        s3 = 1; s4 = 0;
        s5 = 0;
        inp = 5'b01010;
        #10;

        // Test Case 2
        s0 = 0; s1 = 1;
        s2 = 2;
        s3 = 0; s4 = 1;
        s5 = 1;
        inp = 5'b00100;
        #10;

        // Test Case 3
        s0 = 0; s1 = 0;
        s2 = 1;
        s3 = 0; s4 = 1;
        s5 = 1;
        inp = 5'b11111;
        #10;

        $finish();

    end
endmodule

