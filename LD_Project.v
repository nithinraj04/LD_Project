module LD_Project(clk, s0, s1, s2, s3, s4, s5, inp, 
fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2,
actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2,
);
    input clk;
    input s0, s1; // selector for "what device to control"
    input s2; // Device number
    input s3, s4; // What to control in device
    input s5; // fridge/freezer (specific to fridge)

    input [4:0] inp; // input for values
    output [4:0] fgt1, frt1, fgc1, frc1, fgt2, frt2, fgc2, frc2;
    output [4:0] actemp1, accap1, acfan1, actimer1, actemp2, accap2, acfan2, actimer2;

    wire fridge_sel, ac_sel, dummy1, dummy2;
    wire fridge1_sel, fridge2_sel, ac1_sel, ac2_sel;

    demuxFourOne demux0(clk, s0, s1, fridge_sel, ac_sel, dummy1, dummy2);
    demuxTwoOne demux1(fridge_sel, s2, fridge1_sel, fridge2_sel);
    demuxTwoOne demux2(ac_sel, s2, ac1_sel, ac2_sel);

    fridge fridge1(fridge1_sel, s3, s4, s5, inp, fgt1, frt1, fgc1, frc1);
    fridge fridge2(fridge2_sel, s3, s4, s5, inp, fgt2, frt2, fgc2, frc2);
    airconditioner aircon1(ac1_sel, s3, s4, inp, actemp1, accap1, acfan1, actimer1);
    airconditioner aircon2(ac2_sel, s3, s4, inp, actemp2, accap2, acfan2, actimer2);
endmodule
