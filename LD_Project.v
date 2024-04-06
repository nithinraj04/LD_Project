module LD_Project(clk, s0, s1, s2, s3, s4, s5, inp, 
fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2, ice1, ice2,
actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2,
wash, rinse, spin, cloth,
wash_out_1, rinse_out_1, spin_out_1, cloth_out_1,
wash_out_2, rinse_out_2, spin_out_2, cloth_out_2
);
    input clk;
    input s0, s1; // selector for "what device to control"
    input s2; // Device number
    input s3, s4; // What to control in device
    input s5; // fridge/freezer (specific to fridge)
    input [4:0] wash, rinse, spin, cloth; // input for washing machine

    input [4:0] inp; // input for values
    output [4:0] fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2;
    output ice1, ice2;
    output [4:0] actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2;
    output [4:0] wash_out_1, rinse_out_1, spin_out_1, cloth_out_1, wash_out_2, rinse_out_2, spin_out_2, cloth_out_2;

    wire fridge_sel, ac_sel, wm_sel, dummy2;
    wire fridge1_sel, fridge2_sel, ac1_sel, ac2_sel, wm1_sel, wm2_sel;

    demuxFourOne demux0(clk, s0, s1, fridge_sel, ac_sel, wm_sel, dummy2);
    demuxTwoOne demux1(fridge_sel, s2, fridge1_sel, fridge2_sel);
    demuxTwoOne demux2(ac_sel, s2, ac1_sel, ac2_sel);
    demuxTwoOne demux3(wm_sel, s2, wm1_sel, wm2_sel);

    fridge fridge1(fridge1_sel, s3, s4, s5, inp, fgt1, frt1, fgc1, frc1, ice1);
    fridge fridge2(fridge2_sel, s3, s4, s5, inp, fgt2, frt2, fgc2, frc2, ice2);
    airconditioner aircon1(ac1_sel, s3, s4, inp, actemp1, accap1, acfan1, actimer1);
    airconditioner aircon2(ac2_sel, s3, s4, inp, actemp2, accap2, acfan2, actimer2);

    washingMachine wm1(wm1_sel, s3, s4, s5, wash, rinse, spin, cloth, wash_out_1, rinse_out_1, spin_out_1, cloth_out_1);
    washingMachine wm2(wm2_sel, s3, s4, s5, wash, rinse, spin, cloth, wash_out_2, rinse_out_2, spin_out_2, cloth_out_2);
endmodule

