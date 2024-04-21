module BaskinRobbins31(
  input wire clk,        // 클럭 신호
  input wire reset,      // 리셋 신호
  input wire [1:0] player_in,  // 플레이어 입력 신호
  output reg [1:0] comp_in,    // 컴퓨터 입력 신호
  output reg game_over,  // 게임 종료 신호
  output reg player_win  // 플레이어 승리 신호
);
  
  reg [5:0] total;       // 현재까지 더해진 숫자의 합
  reg turn;              // 차례 (0: 플레이어, 1: 컴퓨터)
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      total <= 0;
      turn <= 0;
      game_over <= 0;
      comp_in <= 0;
      player_win <= 0;
    end else if (player_in != 0 && turn == 0) begin
      total <= total + player_in;
      turn <= 1;
      if (total >= 31) begin
        game_over <= 1;
        player_win <= 0;
      end
    end else if (turn == 1) begin
    comp_in <= $urandom_range(1,3);
      total <= total + comp_in;
      turn <= 0;
      if (total >= 31) begin
        game_over <= 1;
        if(total == 31 && turn == 0)
        player_win <= 1;
        else
        player_win <= 0;
      end
    end
  end
  
endmodule