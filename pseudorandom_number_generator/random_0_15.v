module random_0_15 (
    input clk,
    input rst,
    output [3:0] rand_0_15;
);

wire [15:0] rand_big;
reg load;
reg [15:0] seed;

PRNG rng(.clk(clk), .rst(rst), .load(load), .seed(seed), .out(rand_big));

always @(posedge clk) begin
    if (rst) begin
        seed <= 16'hACE1;   
        load <= 1;
    end else begin
        load <= 0;
    end
end

assign rand_0_15 = rand_big % 16;

endmodule