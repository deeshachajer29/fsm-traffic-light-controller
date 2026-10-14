module traffic_light (
    input wire clk,
    input wire rst,

    output reg red,
    output reg green,
    output reg yellow
);

    // States
    parameter RED    = 2'b00;
    parameter GREEN  = 2'b01;
    parameter YELLOW = 2'b10;

    reg [1:0] state;
    reg [1:0] next_state;

    // Counter
    reg [2:0] count;
    reg [2:0] limit;

    // Timer completion signal
    wire timer_done;

    // ------------------------------------------------
    // 1. State Register
    // ------------------------------------------------
    always @(posedge clk) begin
        if (rst)
            state <= RED;
        else
            state <= next_state;
    end

    // ------------------------------------------------
    // 2. Decide the duration of each state
    // ------------------------------------------------
    always @(*) begin

        case (state)

            RED:
                limit = 3'd5;

            GREEN:
                limit = 3'd5;

            YELLOW:
                limit = 3'd2;

            default:
                limit = 3'd5;

        endcase

    end

    // ------------------------------------------------
    // 3. Comparator
    // ------------------------------------------------
    assign timer_done = (count == limit);

    // ------------------------------------------------
    // 4. Counter
    // ------------------------------------------------
    always @(posedge clk) begin

        if (rst)
            count <= 3'd0;

        else if (timer_done)
            count <= 3'd0;

        else
            count <= count + 1'b1;

    end

    // ------------------------------------------------
    // 5. Next-State Logic
    // ------------------------------------------------
    always @(*) begin

        case (state)

            RED: begin
                if (timer_done)
                    next_state = GREEN;
                else
                    next_state = RED;
            end

            GREEN: begin
                if (timer_done)
                    next_state = YELLOW;
                else
                    next_state = GREEN;
            end

            YELLOW: begin
                if (timer_done)
                    next_state = RED;
                else
                    next_state = YELLOW;
            end

            default:
                next_state = RED;

        endcase

    end

    // ------------------------------------------------
    // 6. Output Logic
    // ------------------------------------------------
    always @(*) begin

        red = 0;
        green = 0;
        yellow = 0;

        case (state)

            RED:
                red = 1;

            GREEN:
                green = 1;

            YELLOW:
                yellow = 1;

        endcase

    end

endmodule