module airconditioner(i, s0, s1, inp, temp, cap, fan, timer);
    input i; //power
    input s0, s1; // selector for "what to control"
    input [4:0] inp; // input for values 

    output [4:0] temp; // temperature
    output [7:0] cap; // capacity
    output [4:0] fan; // fan speed
    output [4:0] timer; // timer

    wire temperature, capacity, fan_speed, timer_sel, x;
    wire [4:0] temp_temp_out;
    wire ge, eq, le;

    wire [4:0] lower_bound;
    assign lower_bound = 5'b10001;

    wire [3:0] adder_out;
    wire [4:0] multiple;
    wire [7:0] mult_out;
    assign multiple = 5'b11001;
    assign adder_out[3] = 1'b0;

    demuxFourOne demux(i, s0, s1, temperature, capacity, fan_speed, timer_sel);
    
    not n0(x, i);

    fiveBitComparator comp(inp, lower_bound, le, eq, ge);
    fiveTwoOneMux mux1(inp, lower_bound, le, temp_temp_out);

    rippleCarryAdderTwoBit adder(inp[0], inp[1], i, x, adder_out);
    multiplier mult(multiple, adder_out, mult_out);

    memoryImplementation temp_mem(i, temperature, temp_temp_out[0], temp_temp_out[1], temp_temp_out[2], temp_temp_out[3], temp_temp_out[4], temp[0], temp[1], temp[2], temp[3], temp[4]);
    splMemoryImplementation capacity_fridge(i, capacity, mult_out[0], mult_out[1], mult_out[2], mult_out[3], mult_out[4], mult_out[5], mult_out[6], mult_out[7] ,cap[0], cap[1], cap[2], cap[3], cap[4], cap[5], cap[6], cap[7]);

    memoryImplementation fan_mem(i, fan_speed, inp[0], inp[1], inp[2], x, x, fan[0], fan[1], fan[2], fan[3], fan[4]);
    memoryImplementation timer_mem(i, timer_sel, inp[0], inp[1], inp[2], x, x, timer[0], timer[1], timer[2], timer[3], timer[4]);
endmodule

module oneBitComparator(inp1, inp2, le, eq, ge);
    input inp1, inp2;
    output le, eq, ge;
    wire not_inp1, not_inp2;

    not not0(not_inp1, inp1);
    not not1(not_inp2, inp2);

    and and0(le, not_inp1, inp2);
    and and1(ge, inp1, not_inp2);
    nor nor0(eq, le, ge);
endmodule

module fiveBitComparator(inp1, inp2, le, eq, ge);
    input [4:0] inp1, inp2;
    output le, eq, ge;
    wire le0, le1, le2, le3, le4, eq0, eq1, eq2, eq3, eq4, ge0, ge1, ge2, ge3, ge4;
    wire [3:0] to_le, to_ge;

    oneBitComparator comp0(inp1[4], inp2[4], le4, eq4, ge4);
    oneBitComparator comp1(inp1[3], inp2[3], le3, eq3, ge3);
    oneBitComparator comp2(inp1[2], inp2[2], le2, eq2, ge2);
    oneBitComparator comp3(inp1[1], inp2[1], le1, eq1, ge1);
    oneBitComparator comp4(inp1[0], inp2[0], le0, eq0, ge0);

    and and0(to_le[0], eq4, le3);
    and and1(to_le[1], eq4, eq3, le2);
    and and2(to_le[2], eq4, eq3, eq2, le1);
    and and3(to_le[3], eq4, eq3, eq2, eq1, le0);

    and and4(to_ge[0], eq4, ge3);
    and and5(to_ge[1], eq4, eq3, ge2);
    and and6(to_ge[2], eq4, eq3, eq2, ge1);
    and and7(to_ge[3], eq4, eq3, eq2, eq1, ge0);

    and and8(eq, eq4, eq3, eq2, eq1, eq0);

    or or0(le, le4, to_le[0], to_le[1], to_le[2], to_le[3]);
    or or1(ge, ge4, to_ge[0], to_ge[1], to_ge[2], to_ge[3]);
endmodule

module twoOneMux(inp1, inp2, s, out);
    input inp1, inp2, s;
    output out;
    wire not_s, and_0, and_1;

    not not0(not_s, s);
    and and0(and_0, inp1, not_s);
    and and1(and_1, inp2, s);

    or or0(out, and_0, and_1);
endmodule

module fiveTwoOneMux(inp1, inp2, s, out);
    input [4:0] inp1, inp2;
    input s;
    output [4:0] out;
    
    twoOneMux mux0(inp1[0], inp2[0], s, out[0]);
    twoOneMux mux1(inp1[1], inp2[1], s, out[1]);
    twoOneMux mux2(inp1[2], inp2[2], s, out[2]);
    twoOneMux mux3(inp1[3], inp2[3], s, out[3]);
    twoOneMux mux4(inp1[4], inp2[4], s, out[4]);
endmodule