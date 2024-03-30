module LD_Project(i, s0, s1, inp, temp, cap, fan, timer);
    input i; //power
    input s0, s1; // selector for "what to control"
    input [4:0] inp; // input for values
    output [4:0] temp; // temperature
    output [4:0] cap; // capacity
    output [4:0] fan; // fan speed
    output [4:0] timer; // timer

    airconditioner(i, s0, s1, inp, temp, cap, fan, timer);
endmodule