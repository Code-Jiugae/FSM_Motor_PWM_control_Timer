`timescale 1ns / 1ps

module BCDtoFND(
        input [2:0] i_digitSelect,
        input i_en,
        input [3:0] i_value,

        output [3:0] o_digit,
        output [7:0] o_font
    );

    DigitSelect_Decoder DSD(
        .i_digitSelect(i_digitSelect), // 자리 위치 선택(숫자로 입력)
        .i_en(i_en),
        .o_digit(o_digit) // 자리 위치 선택 (변환된 값 출력)
    );

    BCDtoFND_Decoder BFD(
        .i_value(i_value),  // 출력할 값(숫자로 입력)
        .i_en(i_en),
        .o_font(o_font) // 출력(변환된 값)
    );
endmodule
