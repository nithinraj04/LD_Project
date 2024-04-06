module washingMachine(clk, s0, s1, s2, wash, rinse, spin, cloth, wash_out, rinse_out, spin_out, cloth_out);
    input clk;
    input s0; // Read/write
    input s1, s2; // Preset mode number
    input [4:0] wash, rinse, spin, cloth;
    output [4:0] wash_out, rinse_out, spin_out, cloth_out;
    wire write, read;
    wire reg1, reg2, reg3, reg4;
    wire [4:0] wash_0, rinse_0, spin_0, cloth_0;
    wire [4:0] wash_1, rinse_1, spin_1, cloth_1;
    wire [4:0] wash_2, rinse_2, spin_2, cloth_2;
    wire [4:0] wash_3, rinse_3, spin_3, cloth_3;
    wire choose_output;
    wire [4:0] wash_out_reg, rinse_out_reg, spin_out_reg, cloth_out_reg;

    demuxTwoOne demux0(clk, s0, write, read);
    demuxFourOne demux1(write, s1, s2, reg0, reg1, reg2, reg3);

    washingMachineRegister wm_reg0(clk, reg0, wash, rinse, spin, cloth, wash_0, rinse_0, spin_0, cloth_0);
    washingMachineRegister wm_reg1(clk, reg1, wash, rinse, spin, cloth, wash_1, rinse_1, spin_1, cloth_1);
    washingMachineRegister wm_reg2(clk, reg2, wash, rinse, spin, cloth, wash_2, rinse_2, spin_2, cloth_2);
    washingMachineRegister wm_reg3(clk, reg3, wash, rinse, spin, cloth, wash_3, rinse_3, spin_3, cloth_3);

    and and0(choose_output, read, s0);

    muxFourOneForWM wash_mux(wash_0, wash_1, wash_2, wash_3, s1, s2, wash_out);
    muxFourOneForWM rinse_mux(rinse_0, rinse_1, rinse_2, rinse_3, s1, s2, rinse_out);
    muxFourOneForWM spin_mux(spin_0, spin_1, spin_2, spin_3, s1, s2, spin_out);
    muxFourOneForWM cloth_mux(cloth_0, cloth_1, cloth_2, cloth_3, s1, s2, cloth_out);

    // fiveBitOneBitAnd wash_and(wash_out, wash_out_reg, choose_output);
    // fiveBitOneBitAnd rinse_and(rinse_out, rinse_out_reg, choose_output);
    // fiveBitOneBitAnd spin_and(spin_out, spin_out_reg, choose_output);
    // fiveBitOneBitAnd cloth_and(cloth_out, cloth_out_reg, choose_output);
endmodule

module fiveBitAnd(out, i, inp1, inp2);
    input [4:0] i;
    input inp1, inp2;
    output [4:0] out;
    and and0(out[0], inp1, inp2, i[0]);
    and and1(out[1], inp1, inp2, i[1]);
    and and2(out[2], inp1, inp2, i[2]);
    and and3(out[3], inp1, inp2, i[3]);
    and and4(out[4], inp1, inp2, i[4]);
endmodule

module fiveBitOr(out, inp1, inp2, inp3, inp4);
    input [4:0] inp1, inp2, inp3, inp4;
    output [4:0] out;
    or or0(out[0], inp1[0], inp2[0], inp3[0], inp4[0]);
    or or1(out[1], inp1[1], inp2[1], inp3[1], inp4[1]);
    or or2(out[2], inp1[2], inp2[2], inp3[2], inp4[2]);
    or or3(out[3], inp1[3], inp2[3], inp3[3], inp4[3]);
    or or4(out[4], inp1[4], inp2[4], inp3[4], inp4[4]);
endmodule

module muxFourOneForWM(i1, i2, i3, i4, s0, s1, out);
    input [4:0] i1, i2, i3, i4;
    input s0, s1;
    output [4:0] out;
    wire [4:0] and0, and1, and2, and3;
    wire not_s0, not_s1;
    not not0(not_s0, s0);
    not not1(not_s1, s1);
    fiveBitAnd and_0(and0, i1, not_s0, not_s1);
    fiveBitAnd and_1(and1, i2, not_s0, s1);
    fiveBitAnd and_2(and2, i3, s0, not_s1);
    fiveBitAnd and_3(and3, i4, s0, s1);
    fiveBitOr or0(out, and0, and1, and2, and3);
endmodule
    
module washingMachineRegister(i, sel, wash, rinse, spin, cloth, wash_out, rinse_out, spin_out, cloth_out);
    input i, sel;
    input [4:0] wash, rinse, spin, cloth;
    output [4:0] wash_out, rinse_out, spin_out, cloth_out;

    memoryImplementation wash_mem(i, sel, wash[0], wash[1], wash[2], wash[3], wash[4], wash_out[0], wash_out[1], wash_out[2], wash_out[3], wash_out[4]);
    memoryImplementation rinse_mem(i, sel, rinse[0], rinse[1], rinse[2], rinse[3], rinse[4], rinse_out[0], rinse_out[1], rinse_out[2], rinse_out[3], rinse_out[4]);
    memoryImplementation spin_mem(i, sel, spin[0], spin[1], spin[2], spin[3], spin[4], spin_out[0], spin_out[1], spin_out[2], spin_out[3], spin_out[4]);
    memoryImplementation cloth_mem(i, sel, cloth[0], cloth[1], cloth[2], cloth[3], cloth[4], cloth_out[0], cloth_out[1], cloth_out[2], cloth_out[3], cloth_out[4]);
endmodule

module fiveBitOneBitAnd(out, i, inp);
    input inp;
    input [4:0] i;
    output [4:0] out;

    and and0(out[0], i[0], inp);
    and and1(out[1], i[1], inp);
    and and2(out[2], i[2], inp);
    and and3(out[3], i[3], inp);
    and and4(out[4], i[4], inp);
endmodule