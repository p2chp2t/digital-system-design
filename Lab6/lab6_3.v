/* CSED273 lab6 experiment 3 */
/* lab6_3.v */

`timescale 1ps / 1fs

/* Implement 369 game counter (0, 3, 6, 9, 13, 6, 9, 13, 6 ...)
 * You must first implement D flip-flop in lab6_ff.v
 * then you use D flip-flop of lab6_ff.v */
module counter_369(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    /* Add your code here */
    wire count0_comp, count1_comp, count2_comp, count3_comp;
    
    assign count0_comp = ~count[0];
    assign count1_comp = ~count[1];
    assign count2_comp = ~count[2];
    assign count3_comp = ~count[3];
    
    edge_trigger_D_FF D_D(reset_n, count[3]^count[2], clk, count[3], count3_comp);
    edge_trigger_D_FF D_C(reset_n, count[0], clk, count[2], count2_comp);
    edge_trigger_D_FF D_B(reset_n, count[3]^~count[2], clk, count[1], count1_comp);
    edge_trigger_D_FF D_A(reset_n, ~count[0] | (count[3] & ~count[2]), clk, count[0], count0_comp);
    
    ////////////////////////
	
endmodule
