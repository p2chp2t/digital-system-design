`timescale 1ns / 1ps

module main_fpga (
    input clk,
    input btnCenter,
    input btnTop,
    input btnBottom,
    input btnLeft,
    input btnRight,
    input [15:0] sw,
    output [3:0] ssSel,
    output [7:0] ssDisp,
    output [15:0] led
);
    parameter arg0_str = 16'b0000110010111010;
    parameter arg1_str = 16'b0001110010111010;
    parameter op_str = 16'b1110000111010101;
    parameter res_str = 16'b1110010111011011;

    reg [31:0] counter;
    reg [15:0] gbuf;
    reg [1:0] state;
    reg blinker;
    reg reset;
    reg player_win_temp;
    reg game_over_temp;
    reg [1:0] player_in;
    wire [1:0] comp_in_temp;
    reg [1:0] comp_in;
    wire game_over;
    wire player_win;
    reg [5:0] total;  // 현재까지 더해진 숫자의 합

    initial begin
        reset <= 1;
        player_in <= 0;
        comp_in <=0;
        player_win_temp <= 0;
        game_over_temp <= 0;
        total <= 0;
        counter <= 0;
        gbuf[3:0]   <= 4'b1111;
        gbuf[7:4]   <= 4'b1111;
        gbuf[11:8]  <= (total / 10);
        gbuf[15:12] <= (total % 10);
        state <= 0;
        blinker <= 0;
    end

    assign led = 16'b0000100110011001;

    led_renderer renderer (
        .graphics(gbuf),
        .clk(clk),
        .segSel(ssSel),
        .seg(ssDisp)
    );

    RandomNumberGenerator random_num (
                .clk(clk),
                .reset(reset),
                .random_number(comp_in_temp)
     );
                
    always @(posedge clk) begin
        if (reset) begin
            counter = 0;
            blinker = 0;
            state = 0;
            reset = 0;
            total=0;
            player_in =0;
            comp_in =0;
            player_win_temp =0;
            game_over_temp =0;
        end else begin
            counter = counter + 1;
            blinker = counter[24];

            // Player's turn
            if ((state == 0) && btnCenter&&(!game_over_temp)) begin
                player_in = 2;
                total = total + player_in;  // 플레이어 입력으로 total 값을 업데이트
                state = 1;
                if(total>=31) begin
                player_win_temp = 0;
                game_over_temp = 1;
                end
                counter = 0; 
            end else if ((state == 0) && btnLeft&&(!game_over_temp)) begin
                player_in = 1;
                total = total + player_in;  // 플레이어 입력으로 total 값을 업데이트
                state = 1;
                if(total>=31) begin
                player_win_temp = 0;
                game_over_temp = 1;
                end
                counter = 0; 
            end else if ((state == 0) && btnRight&&(!game_over_temp)) begin
                player_in = 3;
                total = total + player_in;  // 플레이어 입력으로 total 값을 업데이트
                state = 1;
                if(total>=31) begin
                player_win_temp = 0;
                game_over_temp = 1;
                end
                counter = 0; 
            end
            
            
            // Computer's turn
            if (state == 1 && counter >= 200000000 &&(!game_over_temp)) begin
                total = total + comp_in_temp;
                if(total>=31) begin
                player_win_temp = 1;
                game_over_temp = 1;
                end
                state =  0;
                counter = 0;  // Reset counter for the next turn
            end

            // Game over------------------
            if (game_over_temp && player_win_temp) begin
                gbuf[3:0]   = 4'b1011;//w1
                gbuf[7:4]   = 4'b1100;//w2
                gbuf[11:8]  = 1;//1
                gbuf[15:12] = 4'b1110;//n
                if(counter>= 200000000)begin
                reset = 1;
                end
            end
            else if(game_over_temp && !player_win_temp) begin
                gbuf[3:0]   = 4'b1010;//L
                gbuf[7:4]   = 0;//0
                gbuf[11:8]  = 5;//5
                gbuf[15:12] = 4'b1101;//E
                if(counter>= 200000000)begin
                reset = 1;
                end
            end
            else begin
                gbuf[3:0]   = 4'b1111;
                gbuf[7:4]   = 4'b1111;
                gbuf[11:8]  = (total / 10);
                gbuf[15:12] = (total % 10);
            end
        end
    end

endmodule






module led_renderer (
    input [15:0] graphics,
    input clk,
    output reg [3:0] segSel,
    output reg [7:0] seg
);
  integer counter;
  wire [7:0] res0, res1, res2, res3;

  initial begin
    counter <= 0;
    segSel <= 14;
    seg <= 8'b11111111;
  end

  bcd_to_7seg pos0 (
      .bcd(graphics[3:0]),
      .seg(res0)
  );
  bcd_to_7seg pos1 (
      .bcd(graphics[7:4]),
      .seg(res1)
  );
  bcd_to_7seg pos2 (
      .bcd(graphics[11:8]),
      .seg(res2)
  );
  bcd_to_7seg pos3 (
      .bcd(graphics[15:12]),
      .seg(res3)
  );

  always @(posedge clk) begin
    counter <= counter + 1;
    if (counter == 100000) begin
      counter <= 0;
      case (segSel)
        14: begin
          segSel <= 13;
          seg <= res1;
        end
        13: begin
          segSel <= 11;
          seg <= res2;
        end
        11: begin
          segSel <= 7;
          seg <= res3;
        end
        7: begin
          segSel <= 14;
          seg <= res0;
        end
      endcase
    end
  end
endmodule


module bcd_to_7seg (
    input [3:0] bcd,
    output reg [7:0] seg
);

  always @(*) begin
    // dot, center, tl, bl, b, br, tr, t
    case (bcd)
      4'b0000: seg = 8'b11000000;  // 0
      4'b0001: seg = 8'b11111001;  // 1
      4'b0010: seg = 8'b10100100;  // 2
      4'b0011: seg = 8'b10110000;  // 3
      4'b0100: seg = 8'b10011001;  // 4
      4'b0101: seg = 8'b10010010;  // 5
      4'b0110: seg = 8'b10000010;  // 6
      4'b0111: seg = 8'b11111000;  // 7
      4'b1000: seg = 8'b10000000;  // 8
      4'b1001: seg = 8'b10010000;  // 9
      4'b1010: seg = 8'b11000111;  // L
      4'b1011: seg = 8'b11000011;  // w1
      4'b1100: seg = 8'b11100001;  // w2
      4'b1101: seg = 8'b10000110;  // E
      4'b1110: seg = 8'b11001000;  // n
      4'b1111: seg = 8'b11111111;  // off
      default: seg = 8'b11111111;
    endcase
  end
endmodule

module RandomNumberGenerator (
  input clk,
  input reset,
  output reg [1:0] random_number
);

  reg [1:0] lfsr;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr = 2'b11;
      random_number = 0;
    end else begin
      if (lfsr == 2'b00) begin
        lfsr = 2'b11;
      end else begin
        lfsr = {lfsr[0], lfsr[1] ^ lfsr[0]};
      end
      random_number = lfsr;
    end
  end
  
endmodule