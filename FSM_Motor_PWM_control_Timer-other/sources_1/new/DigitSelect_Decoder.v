`timescale 1ns / 1ps

module DigitSelect_Decoder(
        input [2:0] i_digitSelect,
        input i_en,
        output [3:0] o_digit
    );

    reg [3:0] r_digit;

    assign o_digit = r_digit;

    always @(i_digitSelect or i_en) begin
        if(i_en) begin
            r_digit = 4'b1111;
        end
        else begin
            case (i_digitSelect)
                3'b000 : r_digit <= 4'b1110;
                3'b001 : r_digit <= 4'b1101;
                3'b010 : r_digit <= 4'b1011;
                3'b011 : r_digit <= 4'b0111;
                
                3'b100 : r_digit <= 4'b1110;
                3'b101 : r_digit <= 4'b1101;
                3'b110 : r_digit <= 4'b1011;
                3'b111 : r_digit <= 4'b0111;
                default : r_digit = 4'b1111;
            endcase
        end
    end

endmodule
