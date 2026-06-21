module debounce(

input clk,
input rst_n,
input tick,
input async_in,

output reg level,
output reg rise_pulse

);

reg sync1;
reg sync2;
reg last;


always @(posedge clk)
begin
    sync1 <= async_in;
    sync2 <= sync1;
end


always @(posedge clk or negedge rst_n)
begin

if(!rst_n)
begin
    level <= 0;
    last <= 0;
    rise_pulse <= 0;
end

else if(tick)
begin

    rise_pulse <= 0;

    level <= sync2;

    if(sync2 && !last)
        rise_pulse <= 1;

    last <= sync2;

end

end


endmodule