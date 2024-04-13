`timescale 1 ns / 1 ps

module testbench; 
    reg s0, s1; // selector for "what device to control"
    reg s2; // Device number
    reg s3, s4; // What to control in device
    reg s5; // fridge/freezer (specific to fridge)

    reg [4:0] inp; // input for values
    reg [4:0] wash, rinse, spin, cloth; // input for washing machine
    wire [4:0] fgt1, frt1;
    wire [7:0] fgc1, frc1;
    wire ice1;
    wire [4:0] fgt2, frt2;
    wire [7:0] fgc2, frc2;
    wire ice2;
    wire [4:0] actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2;
    wire [4:0] wash_out_1, rinse_out_1, spin_out_1, cloth_out_1, wash_out_2, rinse_out_2, spin_out_2, cloth_out_2;

    reg clk;

    LD_Project inst(clk, s0, s1, s2, s3, s4, s5, inp, 
fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2, ice1, ice2, 
actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2, 
wash, rinse, spin, cloth,
wash_out_1, rinse_out_1, spin_out_1, cloth_out_1,
wash_out_2, rinse_out_2, spin_out_2, cloth_out_2);

    always #5 clk = ~clk;

    initial begin 

        clk = 1;

        $monitor("sel=%b%b%b%b%b%b inp=%b wash=%b rinse=%b spin=%b cloth=%b
fgt1=%b frt1=%b fgc1=%b frc1=%b ice1=%b fgt2=%b frt2=%b fgc2=%b frc2=%b ice2=%b
actemp1=%b accap1=%b acfan1=%b actimer1=%b actemp2=%b accap2=%b acfan2=%b actimer2=%b
wash1=%b rinse1=%b spin1=%b cloth1=%b wash2=%b rinse2=%b spin2=%b cloth2=%b \n", 
s0, s1, s2, s3, s4, s5, inp, wash, rinse, spin, cloth, 
fgt1, frt1, fgc1, frc1, ice1, fgt2, frt2, fgc2, frc2, ice2, 
actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2, 
wash_out_1, rinse_out_1, spin_out_1, cloth_out_1, wash_out_2, rinse_out_2, spin_out_2, cloth_out_2);
        
        // Fridge
        
        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 0; s4 = 0;
        s5 = 0;
        inp = 5'b10101;
        #10

        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 0; s4 = 0;
        s5 = 1;
        inp = 5'b11101;
        #10

        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 0; s4 = 1;
        s5 = 0;
        inp = 5'bxxx11;
        #10

        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 0; s4 = 1;
        s5 = 1;
        inp = 5'bxxx10;
        #10

        s0 = 0; s1 = 0;
        s2 = 0;
        s3 = 1; s4 = 0;
        s5 = 0;
        inp = 5'b00000;
        #10

        // Air Conditioner

        s0 = 0; s1 = 1;
        s2 = 0;
        s3 = 0; s4 = 0;
        s5 = 1'bx;
        inp = 5'b01111;
        #10

        s0 = 0; s1 = 1;
        s2 = 0;
        s3 = 0; s4 = 0;
        s5 = 1'bx;
        inp = 5'b10000;
        #10

        s0 = 0; s1 = 1;
        s2 = 0;
        s3 = 0; s4 = 0;
        s5 = 1'bx;
        inp = 5'b01011;
        #10

        s0 = 0; s1 = 1;
        s2 = 0;
        s3 = 0; s4 = 1;
        s5 = 1'bx;
        inp = 5'bxxx10;
        #10

        s0 = 0; s1 = 1;
        s2 = 0;
        s3 = 1; s4 = 0;
        s5 = 1'bx;
        inp = 5'bxx110;
        #10

        s0 = 0; s1 = 1;
        s2 = 0;
        s3 = 1; s4 = 1;
        s5 = 1'bx;
        inp = 5'bxx100;
        #10

        // Washing machine

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 0;
        s4 = 0; s5 = 0;
        wash = 5'b00111;
        rinse = 5'b01101;
        spin = 5'b01100;
        cloth = 5'b00010;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 0;
        s4 = 0; s5 = 1;
        wash = 5'b01100;
        rinse = 5'b01011;
        spin = 5'b01000;
        cloth = 5'b00011;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 0;
        s4 = 1; s5 = 0;
        wash = 5'b01011;
        rinse = 5'b01001;
        spin = 5'b01101;
        cloth = 5'b00011;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 1;
        s4 = 0; s5 = 0;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 1;
        s4 = 0; s5 = 1;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 1;
        s4 = 1; s5 = 0;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 1;
        s4 = 1; s5 = 1;
        #10

        s0 = 1; s1 = 0;
        s2 = 0;
        s3 = 0;
        s4 = 0; s5 = 0;
        wash = 5'b00000;
        rinse = 5'b00000;
        spin = 5'b00000;
        cloth = 5'b00000;
        #10

        $finish();

    end
endmodule
