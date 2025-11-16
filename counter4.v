module counter4(
    clk,
    reset_n,
    count,
    enable,
    overflow
);

    input wire clk; // clock input
    input wire reset_n; // active low reset input
    input wire enable; // enable counting input

    output reg [3:0] count; // 4 bit count output
    output wire overflow; // overflow flag output

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            count <= 4'b0000; // reset count to 0
        end else begin
            if (enable) begin
                count <= count + 4'b0001; // increment count by 1
            end
        end
    end

    assign overflow = (count == 4'b1111); // set overflow flag when count reaches 15 (max for 4 bits)

endmodule