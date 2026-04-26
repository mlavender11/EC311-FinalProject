module switch_detector (
    input clk,
    input switch,
    output reg out
);

reg previous_switch;

initial begin
    previous_switch <= 1'b0;
    out <= 1'b0;
end

always @(posedge clk) begin
    previous_switch <= switch;

    if (switch == 1'b1 && previous_switch == 1'b0) begin
        out <= 1'b1;
    end
    else begin
        out <= 1'b0;
    end
end
    
endmodule