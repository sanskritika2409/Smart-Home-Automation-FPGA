module clk_en #(parameter CLK_HZ=50000000,
                parameter TICK_HZ=1000)
(
input clk,
input rst_n,
output reg tick
);

localparam DIV = CLK_HZ/TICK_HZ;

reg [$clog2(DIV)-1:0] count;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        count <= 0;
        tick <= 0;
    end
    else
    begin
        tick <= 0;

        if(count == DIV-1)
        begin
            count <= 0;
            tick <= 1;
        end
        else
            count <= count + 1;
    end
end

endmodule