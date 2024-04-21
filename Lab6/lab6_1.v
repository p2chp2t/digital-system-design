/* CSED273 lab6 experiment 1 */
/* lab6_1.v */

`timescale 1ps / 1fs

/* Implement synchronous BCD decade counter (0-9)
 * You must use JK flip-flop of lab6_ff.v */
module decade_counter(input reset_n, input clk, output [3:0] count);

    ////////////////////////
    /* Add your code here */
    wire count0_comp, count1_comp, count2_comp, count3_comp;
    
    assign count0_comp = ~count[0];
    assign count1_comp = ~count[1];
    assign count2_comp = ~count[2];
    assign count3_comp = ~count[3];
    
    edge_trigger_JKFF JK_A(reset_n,1,1,clk,count[0],count0_comp);
    edge_trigger_JKFF JK_B(reset_n,count[0]&~count[3],count[0]&~count[3],clk,count[1],count1_comp);
    edge_trigger_JKFF JK_C(reset_n,count[0]&count[1],count[0]&count[1],clk,count[2],count2_comp);
    edge_trigger_JKFF JK_D(reset_n,count[0]&count[1]&count[2],count[0],clk,count[3],count3_comp); 
    ////////////////////////
	
endmodule