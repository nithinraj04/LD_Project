module LD_Project(i, s0, s1, s2, s3, inp, fgt, frt, fgc, frc, fgp, frp);
    input i; //power
    input s0, s1; // selector for "what to control"
    input s2;  // selector for fridge/freezer
    input s3;  // selector for fridge no:
    input [4:0] inp; // input for values 

    output [4:0] fgt; // fridge temperature
    output [4:0] frt; // freezer temperature
    output [4:0] fgc; // fridge capacity
    output [4:0] frc; // freezer capacity
    output fgp, frp; // fridge and freezer power

    fridge(i, s0, s1, s2, s3, inp, fgt, frt, fgc, frc, fgp, frp);
endmodule