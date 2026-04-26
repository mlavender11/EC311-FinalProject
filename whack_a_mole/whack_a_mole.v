module whack_a_mole(
    input clk, rst,
    input [15:0] swt,
    output [15:0] led,
    output [6:0] cathode,
    output [7:0] anode
);

    wire clk_1khz;              // 1 kHz clock for display
    wire led_active;            // Is LED currently on?
    wire new_led_trigger;       // Pulse to generate new random LED
    wire [3:0] random_led_pos;  // Random position (0-15)
    reg [3:0] current_led;      
    reg [15:0] score;           
    wire [15:0] switch_edges;

    faster_clock_divider clk_div(.in_clk(clk), .out_clk(clk_1khz));
    game_timer timer(.clock(clk), .rst(rst), .led_active(led_active), .new_led_trigger(new_led_trigger));
    random_0_15 rng(.clk(clk), .rst(rst), .rand_0_15(random_led_pos));
    fsm display(.clock(clk_1khz), .sixteen_bit_number(score), .cathode(cathode), .anode(anode));


    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : switch_detectors
            switch_detector det(.clk(clk), .switch(swt[i]), .out(switch_edges[i]));

        end
    endgenerate

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_led <= 4'b0;
            score <= 16'b0;
        end
        else begin
            if (new_led_trigger) begin
                current_led <= random_led_pos;
            end

            if (led_active && switch_edges[current_led]) begin
                score <= score + 1;
            end
        end
    end

    assign led = (led_active) ? (16'b1 << current_led) : 16'b0;



    
endmodule