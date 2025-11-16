`timescale 1ns / 1ps // sets time unit to 1ns and time resolution to 1ps

module tb_counter4;

    reg clk; // for testbench, assigning signals are usually reg and signals driven from DUT are wire
    reg reset_n;
    reg enable;

    wire [3:0] count;
    wire overflow;

    counter4 dut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .count(count),
        .overflow(overflow)
    );
    
    initial clk = 0; // start clock at 0
    always #5 clk = ~clk; // invert clock every 5 time units (5ns) with 10 time units (10ns) period

    initial begin
        // set up waveform dump
        $dumpfile("tb_counter4.vcd");
        $dumpvars(0, tb_counter4);

        // initialize inputs
        reset_n = 0;
        enable = 0;

        #20; // run 20 time units (20ns)
        reset_n = 1; // release reset
        enable = 1; // enable and start counting
        
        #200; // run 200 time units (200ns)
        enable = 0; // disable counting

        #40; // run 40 time units (40ns)

        $finish; // end simulation
    end

    initial begin
        $display("time | rst | en | cnt | ovf"); // print header for table output
        $monitor("%4t  | %b  | %b | %2d | %b",
                $time, reset_n, enable, count, overflow); // monitor changes (prints whenever a signal changes)
    end

endmodule