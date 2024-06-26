
module demuxFourOne(i, s0, s1, y0, y1, y2, y3);
    input i, s0, s1;
    output y0, y1, y2, y3;
    wire [1:0] not_s;
    wire [3:0] and_gate;

    not not_0(not_s[0], s0), not_1(not_s[1], s1);
    and and_0(y0, not_s[0], not_s[1], i);
    and and_1(y1, not_s[0], s1, i);
    and and_2(y2, s0, not_s[1], i);
    and and_3(y3, s0, s1, i);
endmodule

module srlatch(s,r,q); //The inputs should have been ~s and ~r
    input s,r;
    output q;
    wire qbar;
    
    nor n0(q,r,qbar);
    nor n1(qbar,s,q);

endmodule

module demuxTwoOne(i, s0, y0, y1);
    input i, s0;
    output y0, y1;
    wire not_s0;
    
    not not_0(not_s0, s0);
    and and_0(y0, i, not_s0);
    and and_1(y1, i, s0);
endmodule

module memoryFiveBit(i0, i1, i2, i3, i4, ni0, ni1, ni2, ni3, ni4, o0, o1, o2, o3, o4);
    input i0, i1, i2, i3, i4, ni0, ni1, ni2, ni3, ni4;
    output o0, o1, o2, o3, o4;
    wire [4:0] temp;

    srlatch s0(i0, ni0, o0);
    srlatch s1(i1, ni1, o1);
    srlatch s2(i2, ni2, o2);
    srlatch s3(i3, ni3, o3);
    srlatch s4(i4, ni4, o4);
endmodule

module memoryImplementation(i, s0, i0, i1, i2, i3, i4, o0, o1, o2, o3, o4);
    // 1 for write
    // 0 for read
    input i, s0, i0, i1, i2, i3, i4;
    output o0, o1, o2, o3, o4;
    wire deMuxOut;
    wire [9:0] andOut;
    wire [4:0] notOut;

    // twoOneDemuxMod demux(i, s0, deMuxOut);
    and and_gate(deMuxOut, i, s0);

    not not0(notOut[0], i0);
    not not1(notOut[1], i1);
    not not2(notOut[2], i2);
    not not3(notOut[3], i3);
    not not4(notOut[4], i4);

    and and1(andOut[0], deMuxOut, i0);
    and and2(andOut[1], deMuxOut, notOut[0]);
    and and3(andOut[2], deMuxOut, i1);
    and and4(andOut[3], deMuxOut, notOut[1]);
    and and5(andOut[4], deMuxOut, i2);
    and and6(andOut[5], deMuxOut, notOut[2]);
    and and7(andOut[6], deMuxOut, i3);
    and and8(andOut[7], deMuxOut, notOut[3]);
    and and9(andOut[8], deMuxOut, i4);
    and and10(andOut[9], deMuxOut, notOut[4]);

    memoryFiveBit mem(andOut[0], andOut[2], andOut[4], andOut[6], andOut[8], andOut[1], andOut[3], andOut[5], andOut[7], andOut[9], o0, o1, o2, o3, o4);

endmodule

module memoryEightBit(i0, i1, i2, i3, i4, i5, i6, i7, ni0, ni1, ni2, ni3, ni4, ni5, ni6, ni7, o0, o1, o2, o3, o4, o5, o6, o7);
    input i0, i1, i2, i3, i4, i5, i6, i7, ni0, ni1, ni2, ni3, ni4, ni5, ni6, ni7;
    output o0, o1, o2, o3, o4, o5, o6, o7;
    wire [4:0] temp;

    srlatch s0(i0, ni0, o0);
    srlatch s1(i1, ni1, o1);
    srlatch s2(i2, ni2, o2);
    srlatch s3(i3, ni3, o3);
    srlatch s4(i4, ni4, o4);
    srlatch s5(i5, ni5, o5);
    srlatch s6(i6, ni6, o6);
    srlatch s7(i7, ni7, o7);
endmodule

module splMemoryImplementation(i, s0, i0, i1, i2, i3, i4, i5, i6, i7, o0, o1, o2, o3, o4, o5, o6, o7);
    // 1 for write
    // 0 for read
    input i, s0, i0, i1, i2, i3, i4, i5, i6, i7;
    output o0, o1, o2, o3, o4, o5, o6, o7;
    wire deMuxOut;
    wire [15:0] andOut;
    wire [7:0] notOut;

    // twoOneDemuxMod demux(i, s0, deMuxOut);
    and and_gate(power, i, s0);

    not not0(notOut[0], i0);
    not not1(notOut[1], i1);
    not not2(notOut[2], i2);
    not not3(notOut[3], i3);
    not not4(notOut[4], i4);
    not not5(notOut[5], i5);
    not not6(notOut[6], i6);
    not not7(notOut[7], i7);

    and and1(andOut[0], power, i0);
    and and2(andOut[1], power, notOut[0]);
    and and3(andOut[2], power, i1);
    and and4(andOut[3], power, notOut[1]);
    and and5(andOut[4], power, i2);
    and and6(andOut[5], power, notOut[2]);
    and and7(andOut[6], power, i3);
    and and8(andOut[7], power, notOut[3]);
    and and9(andOut[8], power, i4);
    and and10(andOut[9], power, notOut[4]);
    and and11(andOut[10], power, i5);
    and and12(andOut[11], power, notOut[5]);
    and and13(andOut[12], power, i6);
    and and14(andOut[13], power, notOut[6]);
    and and15(andOut[14], power, i7);
    and and16(andOut[15], power, notOut[7]);

    // memoryFiveBit mem(andOut[0], andOut[2], andOut[4], andOut[6], andOut[8], andOut[1], andOut[3], andOut[5], andOut[7], andOut[9], o0, o1, o2, o3, o4);
    memoryEightBit mem(andOut[0], andOut[2], andOut[4], andOut[6], andOut[8], andOut[10], andOut[12], andOut[14], andOut[1], andOut[3], andOut[5], andOut[7], andOut[9], andOut[11], andOut[13], andOut[15], o0, o1, o2, o3, o4, o5, o6, o7);
endmodule



module subtractorForDivider(a, b, cin, diff, cout);
    input a, b, cin;
    output diff, cout;
    wire notb;

    not not0(notb, b);
    fullAdder adder(a, notb, cin, diff, cout);
endmodule

module muxTwoOne(i0, i1, s0, out);
    input i0, i1, s0;
    output out;
    wire not_s0, out0, out1;

    not not_0(not_s0, s0);
    and and_0(out0, i0, not_s0);
    and and_1(out1, i1, s0);
    or or_0(out, out0, out1);
endmodule

module unitOfDivision(a, b, cin, sel, cout, mux_out);
    input a, b, cin, sel;
    output cout, mux_out;
    wire adder_out;

    subtractorForDivider sub(a, b, cin, adder_out, cout);
    muxTwoOne mux0(a, adder_out, sel, mux_out);
endmodule

module rowOfDivision(a0, a1, a2, a3, b0, b1, b2, b3, cout, o0, o1, o2, o3);
    // a/b
    input a0, a1, a2, a3, b0, b1, b2, b3;
    output o0, o1, o2, o3, cout;
    wire c0, c1, c2;
    wire sel;
    
    unitOfDivision unit0(a0, b0, 1, sel, c0, o0);
    unitOfDivision unit1(a1, b1, c0, sel, c1, o1);
    unitOfDivision unit2(a2, b2, c1, sel, c2, o2);
    unitOfDivision unit3(a3, b3, c2, sel, sel, o3);
    assign cout = sel;
endmodule
    

module divider(a, b, q);
    input [8:0] a;
    input [2:0] b;
    output [6:0] q;

    wire [3:0] row0, row1, row2, row3, row4, row5, row6;
    
    rowOfDivision row_0(a[6], a[7], a[8], 0, b[0], b[1], b[2], 0, q[6], row0[0], row0[1], row0[2], row0[3]);
    rowOfDivision row_1(a[5], row0[0], row0[1], row0[2], b[0], b[1], b[2], 0, q[5], row1[0], row1[1], row1[2], row1[3]);
    rowOfDivision row_2(a[4], row1[0], row1[1], row1[2], b[0], b[1], b[2], 0, q[4], row2[0], row2[1], row2[2], row2[3]);
    rowOfDivision row_3(a[3], row2[0], row2[1], row2[2], b[0], b[1], b[2], 0, q[3], row3[0], row3[1], row3[2], row3[3]);
    rowOfDivision row_4(a[2], row3[0], row3[1], row3[2], b[0], b[1], b[2], 0, q[2], row4[0], row4[1], row4[2], row4[3]);
    rowOfDivision row_5(a[1], row4[0], row4[1], row4[2], b[0], b[1], b[2], 0, q[1], row5[0], row5[1], row5[2], row5[3]);
    rowOfDivision row_6(a[0], row5[0], row5[1], row5[2], b[0], b[1], b[2], 0, q[0], row6[0], row6[1], row6[2], row6[3]);
endmodule

module cToF(c, f);
    input [4:0] c;
    output [6:0] f;
    wire [8:0] mult_out;
    wire [6:0] div_out;

    multiplier mult(c, 4'b1001, mult_out);
    divider div(mult_out, 3'b101, div_out);
    sevenBitRippleCarryAdder adder(div_out[0], div_out[1], div_out[2], div_out[3], div_out[4], div_out[5], div_out[6], 0, 0, 0, 0, 0, 1, 0, f);
endmodule