module LD_Project(clk, temp_unit, s0, s1, s2, s3, s4, s5, inp, 
fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2, ice1, ice2,
actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2,
wash, rinse, spin, cloth,
wash_out_1, rinse_out_1, spin_out_1, cloth_out_1, wm1_total_time,
wash_out_2, rinse_out_2, spin_out_2, cloth_out_2, wm2_total_time
);
    input clk;
    input temp_unit;
    input s0, s1; // selector for "what device to control"
    input s2; // Device number
    input s3, s4; // What to control in device
    input s5; // fridge/freezer (specific to fridge)
    input [4:0] wash, rinse, spin, cloth; // input for washing machine
    wire [5:0] null;

    input [4:0] inp; // input for values
    output [6:0] fgt1, frt1;
    output [7:0] fgc1, frc1;
    output [6:0] fgt2, frt2;
    output [7:0] fgc2, frc2;
    output ice1, ice2;
    output [6:0] actemp1; 
    output [7:0] accap1;
    output [4:0] acfan1, actimer1;
    output [6:0] actemp2;
    output [7:0] accap2;
    output [4:0] acfan2, actimer2;
    output [4:0] wash_out_1, rinse_out_1, spin_out_1, cloth_out_1;
    output [7:0] wm1_total_time;
    output [4:0] wash_out_2, rinse_out_2, spin_out_2, cloth_out_2;
    output [7:0] wm2_total_time;

    wire fridge_sel, ac_sel, wm_sel, dummy2;
    wire fridge1_sel, fridge2_sel, ac1_sel, ac2_sel, wm1_sel, wm2_sel;
    wire [4:0] fgt1_temp, frt1_temp;
    wire [4:0] fgt2_temp, frt2_temp;
    wire [4:0] actemp1_temp, actemp2_temp;

    divider div(inp, inp, null);
    
    demuxFourOne demux0(clk, s0, s1, fridge_sel, ac_sel, wm_sel, dummy2);
    demuxTwoOne demux1(fridge_sel, s2, fridge1_sel, fridge2_sel);
    demuxTwoOne demux2(ac_sel, s2, ac1_sel, ac2_sel);
    demuxTwoOne demux3(wm_sel, s2, wm1_sel, wm2_sel);

    fridge fridge1(fridge1_sel, s3, s4, s5, inp, fgt1_temp, frt1_temp, fgc1, frc1, ice1);
    fridge fridge2(fridge2_sel, s3, s4, s5, inp, fgt2_temp, frt2_temp, fgc2, frc2, ice2);
    airconditioner aircon1(ac1_sel, s3, s4, inp, actemp1_temp, accap1, acfan1, actimer1);
    airconditioner aircon2(ac2_sel, s3, s4, inp, actemp2_temp, accap2, acfan2, actimer2);

    washingMachine wm1(wm1_sel, s3, s4, s5, wash, rinse, spin, cloth, wash_out_1, rinse_out_1, spin_out_1, cloth_out_1, wm1_total_time);
    washingMachine wm2(wm2_sel, s3, s4, s5, wash, rinse, spin, cloth, wash_out_2, rinse_out_2, spin_out_2, cloth_out_2, wm2_total_time);

    tempChoice temp1(fgt1_temp, temp_unit, fgt1);
    tempChoice temp2(frt1_temp, temp_unit, frt1);
    tempChoice temp3(fgt2_temp, temp_unit, fgt2);
    tempChoice temp4(frt2_temp, temp_unit, frt2);
    tempChoice temp5(actemp1_temp, temp_unit, actemp1);
    tempChoice temp6(actemp2_temp, temp_unit, actemp2);
endmodule

module tempChoice(inp, sel, out);
    input [4:0] inp;
    input sel;
    output [6:0] out;
    
    wire [6:0] f;

    cToF temp_conv(inp, f);

    muxTwoOne mux0(inp[0], f[0], sel, out[0]);
    muxTwoOne mux1(inp[1], f[1], sel, out[1]);
    muxTwoOne mux2(inp[2], f[2], sel, out[2]);
    muxTwoOne mux3(inp[3], f[3], sel, out[3]);
    muxTwoOne mux4(inp[4], f[4], sel, out[4]);
    muxTwoOne mux5(0, f[5], sel, out[5]);
    muxTwoOne mux6(0, f[6], sel, out[6]);
endmodule
