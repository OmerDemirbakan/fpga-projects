// Traffic light: RED -> RED+YELLOW -> GREEN -> YELLOW -> RED
// counter counts clock cycles; when it reaches duration, the next light turns on.

module traffic_light (
    input  clk, rst,        // rst is asynchronous, active high
    output red, yellow, green
);
    // State encoding
    localparam RED        = 2'b00,
               RED_YELLOW = 2'b01,
               GREEN      = 2'b10,
               YELLOW     = 2'b11;

    // Counter counts 0..value, so a light stays on for (value + 1) clock cycles:
    localparam RED_TIME        = 4,   // 5 cycles
               RED_YELLOW_TIME = 0,   // 1 cycle
               GREEN_TIME      = 4,   // 5 cycles
               YELLOW_TIME     = 1;   // 2 cycles
                                      // full cycle = 13 clock cycles

    reg [1:0] state;
    reg [2:0] counter;    // 3 bits: counts up to 7, enough for the largest value (4)
    reg [2:0] duration;   // target for counter, depends on the current state

    // Combinational: picks the target for the current state
    always @(*) begin
        case (state)
            RED:        duration = RED_TIME;
            RED_YELLOW: duration = RED_YELLOW_TIME;
            GREEN:      duration = GREEN_TIME;
            YELLOW:     duration = YELLOW_TIME;
            default:    duration = RED_TIME;   // invalid state: recover to RED
        endcase
    end

    // Sequential: registers update on the clock edge (non-blocking <=)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state   <= RED;
            counter <= 0;
        end else begin
            if (counter == duration) begin
                counter <= 0;                  // restart for the next light
                case (state)
                    RED:        state <= RED_YELLOW;
                    RED_YELLOW: state <= GREEN;
                    GREEN:      state <= YELLOW;
                    YELLOW:     state <= RED;
                    default:    state <= RED;
                endcase
            end else
                counter <= counter + 1;
        end
    end

    // Outputs: RED_YELLOW turns on both red and yellow
    assign red    = (state == RED)    || (state == RED_YELLOW);
    assign yellow = (state == YELLOW) || (state == RED_YELLOW);
    assign green  = (state == GREEN);
endmodule
