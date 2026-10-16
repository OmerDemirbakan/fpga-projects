module tb_turnstile;
    reg clk, rst, coin, push;
    wire unlocked;

    turnstile DUT (.clk(clk), .rst(rst), .coin(coin), .push(push), .unlocked(unlocked));

    // Clock: period 10, rising edges at t=5, 15, 25, ...
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_turnstile);

        rst = 1; coin = 0; push = 0;
        #12 rst = 0;

        // 1) push while locked: nothing happens, stays locked
        #1  push = 1;
        #10 push = 0;

        // 2) insert a coin: turnstile unlocks
        #10 coin = 1;
        #10 coin = 0;

        // 3) push after the coin: turnstile locks again
        #10 push = 1;
        #10 push = 0;

        #20 $finish;
    end
endmodule
