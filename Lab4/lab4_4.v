/* CSED273 lab4 experiment 4 */
/* lab4_4.v */

/* Implement 5x3 Binary Mutliplier
 * You must use lab4_2 module in lab4_2.v
 * You cannot use fullAdder or halfAdder module directly
 * You may use keword "assign" and bitwise operator
 * or just implement with gate-level modeling*/
module lab4_4(
    input [4:0]in_a,
    input [2:0]in_b,
    output [7:0]out_m
    );

    ////////////////////////
    /* Add your code here */
    wire [4:0] pp0,pp1,pp2;
    assign pp0[0]=in_a[0]&in_b[0];
    assign pp0[1]=in_a[1]&in_b[0];
    assign pp0[2]=in_a[2]&in_b[0];
    assign pp0[3]=in_a[3]&in_b[0];
    assign pp0[4]=in_a[4]&in_b[0];
    
    assign pp1[0]=in_a[0]&in_b[1];
    assign pp1[1]=in_a[1]&in_b[1];
    assign pp1[2]=in_a[2]&in_b[1];
    assign pp1[3]=in_a[3]&in_b[1];
    assign pp1[4]=in_a[4]&in_b[1];
    
    assign pp2[0]=in_a[0]&in_b[2];
    assign pp2[1]=in_a[1]&in_b[2];
    assign pp2[2]=in_a[2]&in_b[2];
    assign pp2[3]=in_a[3]&in_b[2];
    assign pp2[4]=in_a[4]&in_b[2];

    wire [4:0] s0_1;
    wire c0_1;

    assign out_m[0]=pp0[0];
    lab4_2 add1({0,pp0[4:1]},pp1[4:0],0,s0_1,c0_1);
    assign out_m[1]=s0_1[0];
    lab4_2 add2({c0_1,s0_1[4:1]},pp2,0,out_m[6:2],out_m[7]);
    
    ////////////////////////
    
endmodule