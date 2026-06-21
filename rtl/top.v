module top(

input clk,
input reset,


input pir,
input dark,

input temp_high,

input door,

input security,

input manual,


output L0_PWM,

output FAN_PWM,

output RELAY,

output ALARM

);


wire tick;


clk_en clk_unit(

.clk(clk),

.rst_n(~reset),

.tick(tick)

);



wire [7:0] light_value;

wire [7:0] fan_value;



ctrl_fsm controller(

.clk(clk),

.rst_n(~reset),

.pir(pir),

.dark(dark),

.temp_high(temp_high),

.door_open(door),

.security(security),

.manual(manual),


.L0(light_value),

.FAN(fan_value),

.alarm(ALARM)

);



pwm8 light_pwm(

.clk(clk),

.rst_n(~reset),

.tick_1k(tick),

.duty(light_value),

.out(L0_PWM)

);



pwm8 fan_pwm(

.clk(clk),

.rst_n(~reset),

.tick_1k(tick),

.duty(fan_value),

.out(FAN_PWM)

);



assign RELAY = security;


endmodule