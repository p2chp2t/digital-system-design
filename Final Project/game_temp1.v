module BaskinRobbins31(
  input wire clk,        // Ŭ�� ��ȣ
  input wire reset,      // ���� ��ȣ
  input wire [1:0] player_in,  // �÷��̾� �Է� ��ȣ
  output reg [1:0] comp_in,    // ��ǻ�� �Է� ��ȣ
  output reg game_over,  // ���� ���� ��ȣ
  output reg player_win  // �÷��̾� �¸� ��ȣ
);
  
  reg [5:0] total;       // ������� ������ ������ ��
  reg turn;              // ���� (0: �÷��̾�, 1: ��ǻ��)
  
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