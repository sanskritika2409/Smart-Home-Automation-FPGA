`timescale 1ns/1ps


module home_tb;


reg clk=0;

reg reset=1;


reg pir=0;

reg dark=0;

reg temp_high=0;

reg door=0;

reg security=0;

reg manual=0;


wire light;

wire fan;

wire relay;

wire alarm;



top DUT(

.clk(clk),

.reset(reset),

.pir(pir),

.dark(dark),

.temp_high(temp_high),

.door(door),

.security(security),

.manual(manual),


.L0_PWM(light),

.FAN_PWM(fan),

.RELAY(relay),

.ALARM(alarm)

);



always #5 clk=~clk;



initial
begin


$dumpfile("home.vcd");

$dumpvars(0,home_tb);



#50 reset=0;


// motion sensor

#100;

pir=1;

dark=1;


#200;

pir=0;



// temperature

#200;

temp_high=1;


#100;

temp_high=0;



// security alarm

#200;

security=1;

door=1;


#100;


// manual mode

security=0;

door=0;

manual=1;


#200;



$finish;


end


endmodule