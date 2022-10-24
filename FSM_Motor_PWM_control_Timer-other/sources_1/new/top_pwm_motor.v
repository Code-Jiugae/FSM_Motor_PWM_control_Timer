`timescale 1ns / 1ps

module top_pwm_motor(
        input i_clk, i_reset,
        input[4:0] i_btn,
        input[1:0] i_sw,
        output o_pwm,
        output[3:0] o_led,
        output[3:0] o_digit,
        output[7:0] o_font
    );

    wire w_clk;
    clock_divider clk_divid(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk)
    );

    wire[9:0] w_counter;
    wire w_clk_1khz;
    counter cnt(
        .i_clk(w_clk),
        .i_reset(i_reset),
        .o_counter(w_counter),
        .o_clk_1khz(w_clk_1khz)
    );

    wire[3:0] w_pwm;
    comparator copmare(
        .i_counter(w_counter),
        .o_pwm(w_pwm)
    );

    wire[2:0] w_sel;
    mux mux_module(
        .i_x(w_pwm),
        .i_sel(w_sel),
        .o_y(o_pwm)
    );

    wire[4:0] w_btn;
    button_controller btn0(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_btn(i_btn[0]),
        .o_btn(w_btn[0])
    );

    button_controller btn1(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_btn(i_btn[1]),
        .o_btn(w_btn[1])
    );

    button_controller btn2(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_btn(i_btn[2]),
        .o_btn(w_btn[2])
    );

    button_controller btn3(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_btn(i_btn[3]),
        .o_btn(w_btn[3])
    );

    button_controller btn4(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_btn(i_btn[4]),
        .o_btn(w_btn[4])
    );

    
    wire w_state;
    fsm fsm_module(
        .i_clk(i_clk), 
        .i_reset(i_reset),
        .i_state(w_state),
        .i_btn(i_btn),
        .o_speed_state(w_sel)
    );

    LED led_module(
        .i_led_state(w_sel),
        .o_led(o_led)
    );

    wire[2:0] w_fnd_counter;
    counter_fnd cnt_fnd(
        .i_clk(w_clk_1khz),
        .i_reset(i_reset),
        .o_counter(w_fnd_counter)
    );

    wire[3:0] w_sec_mode;
    BCDtoFND fnd(
        .i_digitSelect(w_fnd_counter), // 자리 위치 선택(숫자로 입력)
        .i_en(1'b0),
        .i_value(w_sec_mode),  // 출력할 값(숫자로 입력)

        .o_digit(o_digit),
        .o_font(o_font)
    );

    wire[5:0] w_sec;
    wire[6:0] w_msec;
    
    timer_counter t_cnt(
        .i_clk(w_clk_1khz),
        .i_reset(i_reset),
        .i_sw(i_sw),
        .o_sec(w_sec),
        .o_msec(w_msec),
        .o_state(w_state)
    );

    wire[3:0] w_fnd_dp;
    comperator_point compare_point(
        .i_msec(w_msec),
        .o_fnd_dp(w_fnd_dp)
    );

    wire[3:0] w_sec_10, w_sec_1;
    digit_divider_sec_msec digit_divier_s_ms(
        .i_sec(w_sec), 
        .o_sec_10(w_sec_10), 
        .o_sec_1(w_sec_1)
    );

    


    mux_8x1 mux_81_s_ms(
        .i_a(w_sel), 
        .i_b(11), 
        .i_c(w_sec_1), 
        .i_d(w_sec_10),

        .i_a1(11), 
        .i_b1(11), 
        .i_c1(w_fnd_dp), 
        .i_d1(11),

        .i_sel(w_fnd_counter),
        .o_y(w_sec_mode)
    );

endmodule
