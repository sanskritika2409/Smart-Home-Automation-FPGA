module ctrl_fsm(

input clk,
input rst_n,

input pir,
input dark,
input temp_high,

input door_open,
input security,

input manual,


output reg [7:0] L0,

output reg [7:0] FAN,

output reg alarm

);


always @(posedge clk or negedge rst_n)
begin

if(!rst_n)
begin

L0 <= 0;
FAN <= 0;
alarm <= 0;

end


else
begin


// Safety highest priority

if(door_open && security)
begin

alarm <= 1;

L0 <= 255;
FAN <= 0;

end


// Manual override

else if(manual)
begin

alarm <= 0;

L0 <= 255;

end



// Automatic light

else if(pir && dark)
begin

alarm <= 0;

L0 <= 200;

end



// Temperature control

else if(temp_high)
begin

alarm <= 0;

FAN <= 255;

end



else
begin

L0 <= 0;

FAN <= 0;

alarm <= 0;

end


end

end


endmodule