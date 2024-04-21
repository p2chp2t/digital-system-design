/* CSED273 lab5 experiment 2 */
/* lab5_2.v */

`timescale 1ns / 1ps

/* Implement srLatch */
module srLatch(
    input s, r,
    output q, q_
    );

    ////////////////////////
    /* Add your code here */
    nor(q,r,q_);
    nor(q_,s,q);
    ////////////////////////

endmodule

/* Implement master-slave JK flip-flop with srLatch module */
module lab5_2(
    input reset_n, j, k, clk,
    output q, q_
    );

    ////////////////////////
    /* Add your code here */
    wire s,r,p,p_;
    assign s=!reset_n?0:j&q_&clk;
    assign r=!reset_n?1:k&q&clk;
    srLatch master(s,r,p,p_);
    srLatch slave(p&~clk,p_&~clk,q,q_);
    ////////////////////////
    
endmodule