/* CSED273 lab6 experiments */
/* lab6_tb.v */

`timescale 1ps / 1fs

module lab6_tb();

    integer Passed;
    integer Failed;

    /* Define input, output and instantiate module */
    ////////////////////////
    /* Add your code here */
    reg clk;
    // inputs and outputs for lab6_1
    reg reset1;
    wire [3:0] q1;
    
    // inputs and outputs for lab6_2
    reg reset2;
    wire [7:0] q2;
    
    // inputs and outputs for lab6_3
    reg reset3;
    wire [3:0] q3;
   
    //instantiate modules
    decade_counter u1(.reset_n(reset1), .clk(clk), .count(q1));
    decade_counter_2digits u2(.reset_n(reset2), .clk(clk), .count(q2));
    counter_369 u3(.reset_n(reset3), .clk(clk), .count(q3));
    
    //initialize input
    initial begin
        reset1=0;
        reset2=0;
        reset3=0;
        clk=1'b0;
        #10 clk=1'b0;
        forever
            #5 clk=~clk;
    end
    ////////////////////////

    initial begin
        Passed = 0;
        Failed = 0;

        lab6_1_test;
        lab6_2_test;
        lab6_3_test;

        $display("Lab6 Passed = %0d, Failed = %0d", Passed, Failed);
        $finish;
    end

    /* Implement test task for lab6_1 */
    task lab6_1_test;
        ////////////////////////
        /* Add your code here */
        reg [3:0] expected_value1;
        integer i1;
    begin 
        #10 reset1=1;
        expected_value1=0;
        for (i1 = 0; i1 < 20; i1 = i1 + 1) begin
            #10;
            expected_value1=i1%10;
            // Check the output values
            if (q1 == expected_value1) begin
                Passed = Passed + 1;
            end else begin
                Failed = Failed + 1;
            end
        end
        reset1 = 0;
    end
        ////////////////////////
    endtask

    /* Implement test task for lab6_2 */
    task lab6_2_test;
        ////////////////////////
        /* Add your code here */
        reg [7:0] expected_value2;
        reg [3:0] expected_digit1;
        reg [3:0] expected_digit2;
        reg [3:0] actual_digit1;
        reg [3:0] actual_digit2;
        integer i2;
    begin
        #10 reset2=1;
        expected_value2=0;
        for (i2 = 1; i2 < 200; i2 = i2 + 1) begin
            #10;
            expected_value2 = i2%100;
            // Extract individual digits from expected value
            expected_digit1 = expected_value2%10;
            expected_digit2 = expected_value2/10;
        
            // Extract individual digits from actual value (q2)
            actual_digit1 = q2[3:0];
            actual_digit2 = q2[7:4];
        
            // Check each digit separately
            if ((actual_digit1 == expected_digit1) && (actual_digit2 == expected_digit2)) begin
                Passed = Passed + 1;
            end else begin
                Failed = Failed + 1;
            end
        end
        reset2 = 0;
    end
        ////////////////////////
    endtask

    /* Implement test task for lab6_3 */
    task lab6_3_test;
        ////////////////////////
        /* Add your code here */
        reg [3:0] expected_value3;
        integer i3;
    begin
        #10 reset3 = 1;

        expected_value3 = 3;
        for (i3 = 0; i3 < 16; i3 = i3 + 1) begin
            #10;
            if (q3 == expected_value3) begin
                Passed = Passed + 1;
            end else begin
                Failed = Failed + 1;
            end
            if (expected_value3 == 0) begin
                expected_value3 = 3;
            end else if (expected_value3 == 3) begin
                expected_value3 = 6;
            end else if (expected_value3 == 6) begin
                expected_value3 = 9;
            end else if (expected_value3 == 9) begin
                expected_value3 = 13;
            end else if (expected_value3 == 13) begin
                expected_value3 = 6;
            end else begin
                expected_value3 = 9;
            end
           
         end   
         reset3=0;
      end
        ////////////////////////
    endtask

endmodule