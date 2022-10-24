`timescale 1ns / 1ps

module counter(
        input i_clk,
        input i_reset,
        output[9:0] o_counter, // 1000번 counter
        output o_clk_1khz
    );

    reg[9:0] r_counter = 0;
    reg r_clk_1khz;

    assign o_counter = r_counter;
    assign o_clk_1khz = r_clk_1khz;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            r_counter <= 0;
            r_clk_1khz <= 1'b0;
        end
        else begin
            if(r_counter == 999)begin
                r_counter <= 0;
                r_clk_1khz <= ~r_clk_1khz;
            end
            else if(r_counter == 499)begin
                r_counter <= r_counter + 1;
                r_clk_1khz <= ~r_clk_1khz;
            end

            else begin
                r_counter <= r_counter + 1;
            end
        end
    end
endmodule