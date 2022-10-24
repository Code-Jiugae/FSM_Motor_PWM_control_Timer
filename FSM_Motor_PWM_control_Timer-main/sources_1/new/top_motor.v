`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 13:24:47
// Design Name: 
// Module Name: top_motor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_motor(
    input i_clk, i_reset, i_timer_mode,
    input [2:0] i_button,
    input [1:0] i_button_time,
    output o_pwm,
    output [3:0] o_Led,
    output [7:0] o_font,
    output [3:0] o_position
    );

    wire w_clk_1MHz;

    clock_divider clk_div(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk_1MHz)
    );

    wire [9:0] w_counter_pwm;

    clock_counter clk_cnt(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .o_counter(w_counter_pwm)
    );

    wire [3:0] w_pwm;

    PWM pwm(
    .i_counter(w_counter_pwm),
    .o_pwm(w_pwm)
    );

    wire [2:0] w_pwm_state;

    MUX_4x1 mux_4x1(
    .i_pwm(w_pwm),
    .i_pwm_state(w_pwm_state),
    .o_pwm(o_pwm)
    );

    wire w_clk_1kHz;

    clock_divider_FND clk_div_fnd(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk_1kHz)
    );

    wire [2:0] w_button;

    button upButton(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .i_button(i_button[0]),
    .o_button(w_button[0])
    );

    button downButton(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .i_button(i_button[1]),
    .o_button(w_button[1])
    );

    button offButton(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .i_button(i_button[2]),
    .o_button(w_button[2])
    );

    wire [1:0] w_button_time;

    button plusButton(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .i_button(i_button_time[0]),
    .o_button(w_button_time[0])
    );

    button minusButton(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .i_button(i_button_time[1]),
    .o_button(w_button_time[1])
    );

    wire [4:0] w_time;

    FSM_motor fsm_motor(
    .i_button(w_button),
    .i_reset(i_reset),
    .i_clk(w_clk_1MHz),
    .i_timer_mode(i_timer_mode),
    .i_time(w_time),
    .o_pwm_state(w_pwm_state)
    );

    wire [3:0] w_Fnd;

    display_led_state display_led_state(
    .i_pwm_state(w_pwm_state),
    .o_Led(o_Led)
    );

    display_fnd_state display_fnd_state(
    .i_pwm_state(w_pwm_state),
    .o_Fnd(w_Fnd)
    );

    wire [3:0] w_four, w_three, w_two, w_one;

    digit_divider digit_div(
    .i_timeState(w_time),
    .i_value(w_Fnd),
    .o_four(w_four),
    .o_three(w_three),
    .o_two(w_two),
    .o_one(w_one)
    );

    wire [3:0] w_value;
    wire [1:0] w_digit;
    
    FND_position_MUX_4x1 fnd_position_MUX(
    .i_four(w_four),
    .i_three(w_three),
    .i_two(w_two),
    .i_one(w_one),
    .i_sel(w_digit),
    .o_value(w_value)
    );

    FND_position_counter FND_position_cnt(
    .i_clk(w_clk_1kHz),
    .i_reset(i_reset),
    .o_digit(w_digit)
    );

    FND_position_decoder FND_position(
    .i_digit(w_digit),
    .o_position(o_position)
    );

    BCDtoFND_decoder BCDtoFND_decoder(
    .i_reset(i_reset),
    .i_Fnd(w_value),
    .o_font(o_font)
    );

    wire [4:0] w_timeState;

    FSM_Time fsm_time(
    .i_clk(w_clk_1MHz),
    .i_reset(i_reset),
    .i_button(w_button_time),
    .i_offButton(w_button[2]),
    .i_pwm_state(w_pwm_state),
    .o_timeState(w_timeState)
    );

    wire [4:0] w_time_counter;

    time_clock_counter time_clk_cnt(
    .i_clk(w_clk_1kHz),
    .i_reset(i_reset),
    .i_timer_mode(i_timer_mode),
    .i_offButton(i_button[2]),
    .i_timeState(w_timeState),
    .o_counter(w_time_counter)
    );

    time_comparator time_cmp(
    .i_counter(w_time_counter),
    .i_timeState(w_timeState),
    .i_reset(i_reset),
    .i_clk(w_clk_1kHz),
    .o_time(w_time)
    );

    // wire w_time_output;

    // MUX_3x1 mux_3x1(
    // .i_time(w_time),
    // .i_time_state(w_timeState),
    // .o_time(w_time_output)
    // );
endmodule
