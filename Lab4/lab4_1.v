/* CSED273 lab4 experiment 1 */
/* lab4_1.v */


/* Implement Half Adder
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
module halfAdder(
    input in_a,
    input in_b,
    output out_s,
    output out_c
    );

    ////////////////////////
    /* Add your code here */
    xor U0(out_s,in_a,in_b);
    and U1(out_c,in_a,in_b);
    ////////////////////////

endmodule

/* Implement Full Adder
 * You must use halfAdder module
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
module fullAdder(
    input in_a,
    input in_b,
    input in_c,
    output out_s,
    output out_c
    );

    ////////////////////////
    /* Add your code here */
    wire line_xor,line_and,line_and2;
    halfAdder U0(in_a,in_b,line_xor,line_and);
    halfAdder U1(line_xor,in_c,out_s,line_and2);
    or U2(out_c,line_and,line_and2);
    ////////////////////////

endmodule