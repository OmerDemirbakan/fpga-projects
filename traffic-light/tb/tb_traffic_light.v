module tb_traffic_light;
    reg clk, rst;
    wire red, yellow, green;

    traffic_light DUT (.clk(clk), .rst(rst), .red(red), .yellow(yellow), .green(green));

    // Clock: period 10, rising edges at t=5, 15, 25, ...
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_traffic_light);
        $monitor("t=%0d  red=%b yellow=%b green=%b", $time, red, yellow, green);

        rst = 1;
        #12 rst = 0;     // release reset between clock edges
        #300 $finish;    // a full cycle is 13 clock periods = 130 time units
    end
endmodule
