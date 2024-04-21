/* CSED273 lab2 experiment 1 */
/* lab2_1.v */

/* Unsimplifed equation
 * You are allowed to use keword "assign" and operator "&","|","~",
 * or just implement with gate-level-modeling (and, or, not) */
module lab2_1(
    output wire outGT, outEQ, outLT,
    input wire [1:0] inA,
    input wire [1:0] inB
    );

    CAL_GT cal_gt(outGT, inA, inB);
    CAL_EQ cal_eq(outEQ, inA, inB);
    CAL_LT cal_lt(outLT, inA, inB);
    
endmodule

/* Implement output about "A>B" */
module CAL_GT(
    output wire outGT,
    input wire [1:0] inA,
    input wire [1:0] inB
    );

    ////////////////////////
    /* Add your code here */
    wire temp1, temp2, temp3, temp4, temp5, temp6;
    assign temp1=(~inA[1])&inA[0]&(~inB[1])&(~inB[0]);
    assign temp2=inA[1]&inA[0]&(~inB[1])&(~inB[0]);
    assign temp3=inA[1]&(~inA[0])&(~inB[1])&(~inB[0]);
    assign temp4=inA[1]&inA[0]&(~inB[1])&inB[0];
    assign temp5=inA[1]&(~inA[0])&(~inB[1])&inB[0];
    assign temp6=inA[1]&inA[0]&inB[1]&(~inB[0]);
    assign outGT=temp1|temp2|temp3|temp4|temp5|temp6;
    ////////////////////////

endmodule

/* Implement output about "A=B" */
module CAL_EQ(
    output wire outEQ,
    input wire [1:0] inA, 
    input wire [1:0] inB
    );

    ////////////////////////
    /* Add your code here */
    wire temp1, temp2, temp3, temp4;
    assign temp1=(~inA[1])&(~inA[0])&(~inB[1])&(~inB[0]);
    assign temp2=(~inA[1])&inA[0]&(~inB[1])&inB[0];
    assign temp3=inA[1]&inA[0]&inB[1]&inB[0];
    assign temp4=inA[1]&(~inA[0])&inB[1]&(~inB[0]);
    assign outEQ=temp1|temp2|temp3|temp4;
    ////////////////////////

endmodule

/* Implement output about "A<B" */
module CAL_LT(
    output wire outLT,
    input wire [1:0] inA, 
    input wire [1:0] inB
    );

    ////////////////////////
    /* Add your code here */
    wire temp1, temp2, temp3, temp4, temp5, temp6;
    assign temp1=(~inA[1])&(~inA[0])&(~inB[1])&inB[0];
    assign temp2=(~inA[1])&(~inA[0])&inB[1]&inB[0];
    assign temp3=(~inA[1])&inA[0]&inB[1]&inB[0];
    assign temp4=inA[1]&(~inA[0])&inB[1]&inB[0];
    assign temp5=(~inA[1])&(~inA[0])&inB[1]&(~inB[0]);
    assign temp6=(~inA[1])&inA[0]&inB[1]&(~inB[0]);
    assign outLT=temp1|temp2|temp3|temp4|temp5|temp6;
    ////////////////////////

endmodule