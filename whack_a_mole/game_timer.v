module game_timer (
    input clock,        // Should be 100 MHz clock
    input rst,          
    output reg led_active,
    output reg new_led
);

reg [25:0] count;    
reg state;

initial begin
    state <= 0;
    led_active <= 1'b0;
    new_led <= 1'b0;
    count <= 26'b0;
end

always @(posedge clock or posedge rst)
begin
    if (rst) begin
        state <= 1'b0;
        led_active <= 1'b0;
        new_led <= 1'b0;
        count <= 26'b0;
    end
    else begin
        new_led <= 1'b0;  // Clear the pulse after 1 cycle

        case (state)
            1'b0: begin // LED off for 1 second
                
                
                if (count == 26'd49_999_999) begin // 1s (50M cycles - 1)
                    state <= 1'b1;
                    led_active <= 1'b1;
                    new_led <= 1'b1;    // Pulse to trigger new random LED
                    count <= 26'b0;     // Reset counter
                end
                else begin
                    count <= count + 1; // Use non-blocking
                end
            end 
            1'b1: begin // LED on for 0.5 seconds
                if (count == 26'd24_999_999) begin // 0.5s (25M cycles - 1)
                    state <= 1'b0;
                    led_active <= 1'b0;
                    count <= 26'b0;     // Reset counter
                end
                else begin
                    count <= count + 1; // Use non-blocking
                end
            end 
            default: begin
                state <= 1'b0;
                led_active <= 1'b0;
                new_led <= 1'b0;
                count <= 26'b0;
            end
        endcase
    end
end
    
endmodule