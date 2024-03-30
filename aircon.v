module airconditioner(i, s0, s1, inp, temp, cap, fan, timer);
    input i; //power
    input s0, s1; // selector for "what to control"
    input [4:0] inp; // input for values 

    output [4:0] temp; // temperature
    output [4:0] cap; // capacity
    output [4:0] fan; // fan speed
    output [4:0] timer; // timer

    wire temperature, capacity, fan_speed, timer_sel, x;

    demuxFourOne demux(i, s0, s1, temperature, capacity, fan_speed, timer_sel);
    
    not n0(x, i);
    memoryImplementation temperature_mem(i, temperature, inp[0], inp[1], inp[2], inp[3], inp[4], temp[0], temp[1], temp[2], temp[3], temp[4]);
    memoryImplementation capacity_mem(i, capacity, inp[0], inp[1], x, x, x, cap[0], cap[1], cap[2], cap[3], cap[4]);
    memoryImplementation fan_mem(i, fan_speed, inp[0], inp[1], inp[2], x, x, fan[0], fan[1], fan[2], fan[3], fan[4]);
    memoryImplementation timer_mem(i, timer_sel, inp[0], inp[1], inp[2], x, x, timer[0], timer[1], timer[2], timer[3], timer[4]);
endmodule
