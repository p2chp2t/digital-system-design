module BaskinRobbins31_TB;
  
  reg clk;
  reg reset;
  reg [1:0] player_in;
  wire [1:0] comp_in;
  wire game_over;
  wire player_win;
  reg [5:0] total;  // 현재까지 더해진 숫자의 합
  
  BaskinRobbins31 dut (
    .clk(clk),
    .reset(reset),
    .player_in(player_in),
    .comp_in(comp_in),
    .game_over(game_over),
    .player_win(player_win)
  );
  
  initial begin
    // 초기화
    clk = 0;
    reset = 1;
    player_in = 0;
    total = 0;
    
    #5 reset = 0;
    
    // 게임 진행
    repeat (20) begin
      // 플레이어 입력
      player_in = $urandom_range(1, 3);
      #10;
      total = total + player_in;
      $display("플레이어: %d, 현재까지의 합: %d", player_in, total);
      
      // 게임 종료 체크
      if (total >= 31) begin
        if (player_win)
          $display("게임 종료 - 플레이어 승리");
        else
          $display("게임 종료 - 컴퓨터 승리");
        $finish;
      end
      
      // 컴퓨터 입력
      #10;
      total = total + comp_in;
      $display("컴퓨터: %d, 현재까지의 합: %d", comp_in, total);
      
      // 게임 종료 체크
      if (total >= 31) begin
        if (player_win)
          $display("게임 종료 - 플레이어 승리");
        else
          $display("게임 종료 - 컴퓨터 승리");
        $finish;
      end
    end
    
    // 종료 후 재시작
    #10;
    reset = 1;
    #5 reset = 0;
    
    // 게임 진행
    repeat (10) begin
      // 플레이어 입력
      player_in = $urandom_range(1, 3);
      #10;
      total = total + player_in;
      $display("플레이어: %d, 현재까지의 합: %d", player_in, total);
      
      // 게임 종료 체크
      if (total >= 31) begin
        if (player_win)
          $display("게임 종료 - 플레이어 승리");
        else
          $display("게임 종료 - 컴퓨터 승리");
        $finish;
      end
      
      // 컴퓨터 입력
      #10;
      total = total + comp_in;
      $display("컴퓨터: %d, 현재까지의 합: %d", comp_in, total);
      
      // 게임 종료 체크
      if (total >= 31) begin
        if (player_win)
          $display("게임 종료 - 플레이어 승리");
        else
          $display("게임 종료 - 컴퓨터 승리");
        $finish;
      end
    end
    
    $finish;
  end
  
  always begin
    #5 clk = ~clk;
  end
  
endmodule