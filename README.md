# User Manual

Welcome!

Using this centralized home automation system, you can control two fridges, two air conditioners and two washing machines. Pls don't ask me why I chose this topic.

The input lines `s0` through `s5` are the selector lines.

`s0` and `s1` are used to select the appliance to control:\
0 0 => Refrigerator\
0 1 => Air Conditioner\
1 0 => Washing Machine

`s2` is used to select the appliance number (in this project, I've included support for only upto 2 appliances each)

The functionalities of `s3`, `s4` and `s5` are device specific. 

### Refrigerator

You can control temperature and capacity of both fridge and freezer individually. Moreover, you can enable or disable the icemaker through this system. The input lines `s3` and `s4` are used to choose operation, and the input line `s5` is used to choose between the fridge and the freezer. The opcodes are as follows:

0 0 0 => Fridge temperature\
0 0 1 => Freezer temperature\
0 1 0 => Fridge capcity\
0 1 1 => Freezer capacity\
1 0 x => Ice maker

The five bits of `Inp` pin is used to give input values for the selected operation. Temperature control takes 5 bit signed values (-16°C to 16°C for freezer and only positive values are considered for fridge). Capacity takes 2 bit input of format 000xx (25%, 50%, 75% and 100%) for both fridge and freezer. Ice maker takes a single bit input (on or off) in the format 0000x.

### Air Conditioner

You can control temperature, capacity, fan speed and timer using this device. The input lines `s3` and `s4` used for choosing the operation and the port `s5` is not used for this device. It can be fed with a dummy input. The opcodes are as follows

0 0 => Temperature\
0 1 => Capacity\
1 0 => Fan speed\
1 1 => Timer

The five bits of `Inp` pin is used to give input values for the selected operation. Temperature control takes 4 bit unsigned values (16°C to 32°C) of format 0xxxx. Capacity takes 2 bit input of format 000xx (25%, 50%, 75% and 100%). Both fan speed and timer takes 3 bit input values of format 00xxx.

### Washing Machine

You can control wash time, rinse time, spin time and cloth type using this device. Three different such presets can be stored and later be used. The port `s3` is used to chose between whether to write to ther registers or to read from the registers. The ports `s4` and `s5` are used to choose the preset number (i.e, mode1, mode2, mode3 and mode4). If you write to a register, the output will automatically be set to that register.

0 0 0 => Write to mode 1\
0 0 1 => Write to mode 2\
0 1 0 => Write to mode 3\
1 0 0 => Read/run mode 1\
1 0 1 => Read/run mode 2\
1 1 0 => Read/run mode 3

Note that this device uses the four 4-bit input ports `wash`, `rinse`, `spin` and `cloth`; rather than the standard input port `inp`. To reset all input, choose a register (preferrably 1 1) in write mode and set all the input ports to zero.

