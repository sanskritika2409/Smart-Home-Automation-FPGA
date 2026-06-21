module scenes(

input [2:0] index,

output reg [7:0] L0,
output reg [7:0] L1,
output reg [7:0] L2,
output reg [7:0] L3,

output reg [7:0] F0,
output reg [7:0] F1,

output reg [3:0] R

);


always @(*)
begin

case(index)

3'd0:
begin
L0=0;
L1=0;
L2=0;
L3=0;
F0=0;
F1=0;
R=0;
end


3'd1:
begin
L0=200;
L1=100;
L2=50;
L3=0;
F0=0;
F1=0;
R=4'b0001;
end


3'd2:
begin
L0=255;
L1=200;
L2=0;
L3=0;
F0=150;
F1=0;
R=4'b0011;
end


3'd3:
begin
L0=20;
L1=20;
L2=0;
L3=0;
F0=0;
F1=0;
R=0;
end


default:
begin
L0=0;
L1=0;
L2=0;
L3=0;
F0=0;
F1=0;
R=0;
end

endcase

end

endmodule