module fridge(i, s0, s1, s2, inp, fgt, frt, fgc, frc);
    input i; //power
    input s0, s1; // selector for "what to control"
    input s2;  // selector for fridge/freezer
    input [4:0] inp; // input for values 

    output [4:0] fgt; // fridge temperature
    output [4:0] frt; // freezer temperature
    output [4:0] fgc; // fridge capacity
    output [4:0] frc; // freezer capacity

    wire temp, capacity, power, y3, y4; 
    wire fridge_temp, freezer_temp, fridge_capacity, freezer_capacity, fridge_power, freezer_power, x;
    
    demuxFourOne demux(i, s0, s1, temp, capacity, power, y3);
    demuxTwoOne temperature_sel(temp, s2, fridge_temp, freezer_temp);
    demuxTwoOne capacity_sel(capacity, s2, fridge_capacity, freezer_capacity);
    demuxTwoOne power_sel(power, s2, fridge_power, freezer_power);

    not n0(x, i);

    memoryImplementation temperature_fridge(i, fridge_temp, inp[0], inp[1], inp[2], inp[3], inp[4], fgt[0], fgt[1], fgt[2], fgt[3], fgt[4]);
    memoryImplementation temperature_freezer(i, freezer_temp, inp[0], inp[1], inp[2], inp[3], inp[4], frt[0], frt[1], frt[2], frt[3], frt[4]);
    memoryImplementation capacity_fridge(i, fridge_capacity, inp[0], inp[1], x, x, x, fgc[0], fgc[1], fgc[2], fgc[3], fgc[4]);
    memoryImplementation capacity_freezer(i, freezer_capacity, inp[0], inp[1], x, x, x, frc[0], frc[1], frc[2], frc[3], frc[4]);
endmodule