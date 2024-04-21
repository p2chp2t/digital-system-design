/* CSED273 lab3 experiment 3 */
/* lab3_3.v */


/* 8-to-1 Multiplexer
 * You must use this module to implement 5-bit Majority Function */
module mux(
    input wire [7:0] data_input,
    input wire [2:0] select_input,
    output wire out
    );

    wire i0, i1, i2, i3, i4, i5, i6, i7;
    and(i0, ~select_input[2], ~select_input[1], ~select_input[0], data_input[0]);
    and(i1, ~select_input[2], ~select_input[1],  select_input[0], data_input[1]);
    and(i2, ~select_input[2],  select_input[1], ~select_input[0], data_input[2]);
    and(i3, ~select_input[2],  select_input[1],  select_input[0], data_input[3]);
    and(i4,  select_input[2], ~select_input[1], ~select_input[0], data_input[4]);
    and(i5,  select_input[2], ~select_input[1],  select_input[0], data_input[5]);
    and(i6,  select_input[2],  select_input[1], ~select_input[0], data_input[6]);
    and(i7,  select_input[2],  select_input[1],  select_input[0], data_input[7]);
    or(out, i0, i1, i2, i3, i4, i5, i6, i7);

endmodule


/* Implement 5-bit Majority Function
 * You are allowed to use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
module lab3_3(
    input wire [4:0] in,
    output wire out
    );

    ////////////////////////
    /* Add your code here */
    wire [7:0] i;
    assign i[0]=0;
    assign i[1]=in[1]&in[0];
    assign i[2]=in[1]&in[0];
    assign i[3]=in[1]||in[0];
    assign i[4]=in[1]&in[0];
    assign i[5]=in[1]||in[0];
    assign i[6]=in[1]||in[0];
    assign i[7]=1;
    
    wire [2:0] s;
    assign s[0]=in[4];
    assign s[1]=in[3];
    assign s[2]=in[2];
    
    mux mux1(
    .data_input(i),
    .select_input(s),
    .out(out)
    );
    ////////////////////////

endmodule