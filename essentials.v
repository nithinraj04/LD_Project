
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

module srlatch(s,r,qbar); //The inputs should have been ~s and ~r
    input s,r;
    output qbar;
    wire q;

    nor n0(qbar,r,q);
    nor n1(q,s,qbar);
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
