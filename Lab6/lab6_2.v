/* CSED273 lab6 experiment 2 */
/* lab6_2.v */

`timescale 1ps / 1fs

/* Implement 2-decade BCD counter (0-99)
 * You must use decade BCD counter of lab6_1.v */
module decade_counter_2digits(input reset_n, input clk, output [7:0] count);

    ////////////////////////
    /* Add your code here */
    wire [3:0] count_digit1;
    wire [3:0] count_digit2;
    wire cp;

    decade_counter digit_1(reset_n, clk, count_digit1);
    assign count[3:0] = count_digit1;

    assign cp = count_digit1[0] & count_digit1[3];

    decade_counter digit_2(reset_n, cp, count_digit2);
    assign count[7:4] = count_digit2;
    ////////////////////////
	
endmodule
