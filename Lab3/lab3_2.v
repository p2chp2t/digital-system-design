/* CSED273 lab3 experiment 2 */
/* lab3_2.v */


/* Implement Prime Number Indicator & Multiplier Indicator
 * You may use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
 
/* 11: out_mul[4], 7: out_mul[3], 5: out_mul[2],
 * 3: out_mul[1], 2: out_mul[0] */
module lab3_2(
    input wire [3:0] in,
    output wire out_prime,
    output wire [4:0] out_mul
    );

    ////////////////////////
    /* Add your code here */
    
    wire tmp1,tmp2,tmp3,tmp4;
    assign tmp1=~in[3]&in[1]&in[0];
    assign tmp2=~in[2]&in[1]&in[0];
    assign tmp3=~in[3]&~in[2]&in[1];
    assign tmp4=in[2]&~in[1]&in[0];
    assign out_prime=tmp1||tmp2||tmp3||tmp4;
      
    assign out_mul[4]=in[3]&~in[2]&in[1]&in[0]; //11
    assign out_mul[3]=(~in[3]&in[2]&in[1]&in[0])||(in[3]&in[2]&in[1]&~in[0]); //7
    assign out_mul[2]=(~in[3]&in[2]&~in[1]&in[0])||(in[3]&~in[2]&in[1]&~in[0])||(in[3]&in[2]&in[1]&in[0]); //5
    assign out_mul[1]=(~in[3]&~in[2]&in[1]&in[0])||(~in[3]&in[2]&in[1]&~in[0])||(in[3] 
    &in[2]&~in[1]&~in[0])||(in[3]&in[2]&in[1]&in[0])||(in[3]&~in[2]&~in[1]&in[0]); //3
    assign out_mul[0]=(in[3]&~in[1]&~in[0])||(in[2]&~in[1]&~in[0])||(in[1]&~in[0]); //2
   
    ////////////////////////

endmodule