/* CSED273 lab3 experiment 1 */
/* lab3_1.v */


/* Active Low 2-to-4 Decoder
 * You must use this module to implement Active Low 4-to-16 decoder */
module decoder(
    input wire en,
    input wire [1:0] in,
    output wire [3:0] out 
    );

    nand(out[0], ~in[0], ~in[1], ~en);
    nand(out[1],  in[0], ~in[1], ~en);
    nand(out[2], ~in[0],  in[1], ~en);
    nand(out[3],  in[0],  in[1], ~en);

endmodule


/* Implement Active Low 4-to-16 Decoder
 * You may use keword "assign" and operator "&","|","~",
 * or just implement with gate-level modeling (and, or, not) */
module lab3_1(
    input wire en,
    input wire [3:0] in,
    output wire [15:0] out
    );

    ////////////////////////
    /* Add your code here */
    wire [3:0] selector_out, dec0_out, dec1_out, dec2_out, dec3_out;
    
    decoder selector(en, in[3:2], selector_out);
    decoder dec0(selector_out[0], in[1:0], dec0_out);
    decoder dec1(selector_out[1], in[1:0], dec1_out);
    decoder dec2(selector_out[2], in[1:0], dec2_out);
    decoder dec3(selector_out[3], in[1:0], dec3_out);
    assign out[3:0] = dec0_out;
    assign out[7:4] = dec1_out;
    assign out[11:8] = dec2_out;
    assign out[15:12] = dec3_out;
    
 
    ////////////////////////

endmodule
