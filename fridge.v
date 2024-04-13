module fridge(i, s0, s1, s2, inp, fgt, frt, fgc, frc, ice);
    input i; //power
    input s0, s1; // selector for "what to control"
    input s2;  // selector for fridge/freezer
    input [4:0] inp; // input for values 

    output [4:0] fgt; // fridge temperature
    output [4:0] frt; // freezer temperature
    output [7:0] fgc; // fridge capacity
    output [7:0] frc; // freezer capacity
    output ice; // ice maker

    wire temp, capacity, ice_maker_sel, y3, y4; 
    wire fridge_temp, freezer_temp, fridge_capacity, freezer_capacity;
    wire [2:0] adder_out;
    wire [4:0] multiple;
    wire [7:0] mult_out;
    assign multiple = 5'b11001;
    
    demuxFourOne demux(i, s0, s1, temp, capacity, ice_maker_sel, y3);
    demuxTwoOne temperature_sel(temp, s2, fridge_temp, freezer_temp);
    demuxTwoOne capacity_sel(capacity, s2, fridge_capacity, freezer_capacity);

    not n0(x, i);

    memoryImplementation temperature_fridge(i, fridge_temp, inp[0], inp[1], inp[2], inp[3], inp[4], fgt[0], fgt[1], fgt[2], fgt[3], fgt[4]);
    memoryImplementation temperature_freezer(i, freezer_temp, inp[0], inp[1], inp[2], inp[3], inp[4], frt[0], frt[1], frt[2], frt[3], frt[4]);

    rippleCarryAdderTwoBit adder(inp[0], inp[1], i, x, adder_out);
    multiplier mult(multiple, adder_out, mult_out);

    splMemoryImplementation capacity_fridge(i, fridge_capacity, mult_out[0], mult_out[1], mult_out[2], mult_out[3], mult_out[4], mult_out[5], mult_out[6], mult_out[7] ,fgc[0], fgc[1], fgc[2], fgc[3], fgc[4], fgc[5], fgc[6], fgc[7]);
    splMemoryImplementation capacity_freezer(i, freezer_capacity, mult_out[0], mult_out[1], mult_out[2], mult_out[3], mult_out[4], mult_out[5], mult_out[6], mult_out[7], frc[0], frc[1], frc[2], frc[3], frc[4], frc[5], frc[6], frc[7]);

    icemaker ice_maker(ice_maker_sel, inp[0], ice);
endmodule

module icemaker(power, inp, out);
    // input i; //power
    input power; // selector 
    input inp; // input value

    output out;

    wire ninp, inp0, ninp0;

    not not0(ninp, inp);
    and and1(inp0, power, inp);
    and and2(ninp0, power, ninp);

    srlatch srl(inp0, ninp0, out);
endmodule

module halfAdder(a, b, sum, carry);
    input a, b;
    output sum, carry;
    xor xor0(sum, a, b);
    and and0(carry, a, b);
endmodule

module fullAdder(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    wire s1, c1, c2;
    halfAdder ha0(a, b, s1, c1);
    halfAdder ha1(s1, cin, sum, c2);
    or or0(cout, c1, c2);
endmodule

module rippleCarryAdderTwoBit(a0, a1, b0, b1, out);
    input a0, a1, b0, b1;
    output [2:0] out;
    wire c0, c1;
    fullAdder fa0(a0, b0, 0, out[0], c0);
    fullAdder fa1(a1, b1, c0, out[1], c1);
    or or0(out[2], c0, c1);
endmodule

module rowAndForMultiplier(a, b, out);
    input [4:0] a;
    input b;
    output [4:0] out;
    wire [4:0] and0, and1, and2, and3, and4;
    and and_0(out[0], a[0], b);
    and and_1(out[1], a[1], b);
    and and_2(out[2], a[2], b);
    and and_3(out[3], a[3], b);
    and and_4(out[4], a[4], b);
endmodule

module multiplier(a, b, out);
    input [4:0] a;
    input [2:0] b;
    output [7:0] out;

    wire [4:0] first_row_and, second_row_and, third_row_and;
    wire c0, c1, c2, c3, c4, c5, c6, c7, c8;
    wire s0, s1, s2, s3;

    and and00(out[0], a[0], b[0]);

    rowAndForMultiplier row0(a, b[0], first_row_and);
    rowAndForMultiplier row1(a, b[1], second_row_and);
    rowAndForMultiplier row2(a, b[2], third_row_and);

    halfAdder ha0(first_row_and[1], second_row_and[0], out[1], c0);
    fullAdder fa0(first_row_and[2], second_row_and[1], c0, s0, c1);
    fullAdder fa1(first_row_and[3], second_row_and[2], c1, s1, c2);
    fullAdder fa2(first_row_and[4], second_row_and[3], c2, s2, c3);
    halfAdder ha1(c3, second_row_and[4], s3, c4);

    halfAdder ha2(s0, third_row_and[0], out[2], c5);
    fullAdder fa3(s1, third_row_and[1], c5, out[3], c6);
    fullAdder fa4(s2, third_row_and[2], c6, out[4], c7);
    fullAdder fa5(s3, third_row_and[3], c7, out[5], c8);
    fullAdder fa6(c4, third_row_and[4], c8, out[6], out[7]);

endmodule


