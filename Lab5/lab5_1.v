/* CSED273 lab5 experiment 1 */
/* lab5_1.v */

`timescale 1ps / 1fs

/* Implement adder 
 * You must not use Verilog arithmetic operators */
module adder(
    input [3:0] x,
    input [3:0] y,
    input c_in,             // Carry in
    output [3:0] out,
    output c_out            // Carry out
); 

    ////////////////////////
    /* Add your code here */
    wire u0, u1, u2;
    assign out[0]=x[0]^y[0]^c_in;
    assign u0=(x[0]&y[0])|(x[0]&c_in)|(y[0]&c_in);
    assign out[1]=x[1]^y[1]^u0;
    assign u1=(x[1]&y[1])|(x[1]&u0)|(y[1]&u0);
    assign out[2]=x[2]^y[2]^u1;
    assign u2=(x[2]&y[2])|(x[2]&u1)|(y[2]&u1);
    assign out[3]=x[3]^y[3]^u2;
    assign c_out=(x[3]&y[3])|u2&(x[3]^y[3]);
    ////////////////////////

endmodule

/* Implement arithmeticUnit with adder module
 * You must use one adder module.
 * You must not use Verilog arithmetic operators */
module arithmeticUnit(
    input [3:0] x,
    input [3:0] y,
    input [2:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    /* Add your code here */
    wire [3:0] a;
    assign a[0]=(select[2]&~y[0])|(select[1]&y[0]);
    assign a[1]=(select[2]&~y[1])|(select[1]&y[1]);
    assign a[2]=(select[2]&~y[2])|(select[1]&y[2]);
    assign a[3]=(select[2]&~y[3])|(select[1]&y[3]);
    adder Arithmetic(a, x, select[0],out,c_out);
    ////////////////////////

endmodule

/* Implement 4:1 mux */
module mux4to1(
    input [3:0] in,
    input [1:0] select,
    output out
);

    ////////////////////////
    /* Add your code here */
    assign out=select[1]?(select[0]?in[3]:in[2]):(select[0]?in[1]:in[0]);
    ////////////////////////

endmodule

/* Implement logicUnit with mux4to1 */
module logicUnit(
    input [3:0] x,
    input [3:0] y,
    input [1:0] select,
    output [3:0] out
);

    ////////////////////////
    /* Add your code here */
    wire [3:0] d0, d1, d2, d3;
    assign d3=~x;
    assign d2=x^y;
    assign d1=x|y;
    assign d0=x&y;
    mux4to1 Logic0({d3[0],d2[0],d1[0],d0[0]},select,out[0]);
    mux4to1 Logic1({d3[1],d2[1],d1[1],d0[1]},select,out[1]);
    mux4to1 Logic2({d3[2],d2[2],d1[2],d0[2]},select,out[2]);
    mux4to1 Logic3({d3[3],d2[3],d1[3],d0[3]},select,out[3]);

    ////////////////////////

endmodule

/* Implement 2:1 mux */
module mux2to1(
    input [1:0] in,
    input  select,
    output out
);

    ////////////////////////
    /* Add your code here */
    assign out=select?in[1]:in[0];
    ////////////////////////

endmodule

/* Implement ALU with mux2to1 */
module lab5_1(
    input [3:0] x,
    input [3:0] y,
    input [3:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    /* Add your code here */
    wire [3:0] d0, d1;
    arithmeticUnit Arithmetic(x,y,select[2:0],d0,c_out);
    logicUnit Logic(x,y,select[1:0],d1);
    mux2to1 ALU0({d1[0],d0[0]},select[3],out[0]);
    mux2to1 ALU1({d1[1],d0[1]},select[3],out[1]);
    mux2to1 ALU2({d1[2],d0[2]},select[3],out[2]);
    mux2to1 ALU3({d1[3],d0[3]},select[3],out[3]);
    ////////////////////////

endmodule
