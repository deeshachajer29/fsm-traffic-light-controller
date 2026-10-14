`timescale 1ns/1ps

module traffic_light_tb;

    reg clk;
    reg rst;
    reg timer_done;

    wire red;
    wire green;
    wire yellow;

    // Instantiate the traffic light
    traffic_light uut (
        .clk(clk),
        .rst(rst),
        .timer_done(timer_done),
        .red(red),
        .green(green),
        .yellow(yellow)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Create waveform
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);

        // Initial values
        clk = 0;
        rst = 1;
        timer_done = 0;

        // Keep reset active
        #10;

        // Release reset
        rst = 0;

        // Stay RED
        timer_done = 0;
        #20;

        // RED → GREEN
        timer_done = 1;
        #10;

        // Stay GREEN
        timer_done = 0;
        #20;

        // GREEN → YELLOW
        timer_done = 1;
        #10;

        // Stay YELLOW
        timer_done = 0;
        #20;

        // YELLOW → RED
        timer_done = 1;
        #10;

        $finish;

    end

endmodule