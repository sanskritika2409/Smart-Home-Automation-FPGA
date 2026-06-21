module pwm8(

input clk,
input rst_n,
input tick_1k,

input [7:0] duty,

output reg out

);


reg [7:0] counter;


always @(posedge clk or negedge rst_n)
begin

if(!rst_n)
begin
counter <= 0;
out <= 0;
end

else if(tick_1k)
begin

counter <= counter + 1;

if(counter < duty)
    out <= 1;
else
    out <= 0;

end

end


endmodule