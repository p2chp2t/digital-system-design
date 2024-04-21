module BaskinRobbins31_TB;
  
  reg clk;
  reg reset;
  reg [1:0] player_in;
  wire [1:0] comp_in;
  wire game_over;
  wire player_win;
  reg [5:0] total;  // ������� ������ ������ ��
  
  BaskinRobbins31 dut (
    .clk(clk),
    .reset(reset),
    .player_in(player_in),
    .comp_in(comp_in),
    .game_over(game_over),
    .player_win(player_win)
  );
  
  initial begin
    // �ʱ�ȭ
    clk = 0;
    reset = 1;
    player_in = 0;
    total = 0;
    
    #5 reset = 0;
    
    // ���� ����
    repeat (20) begin
      // �÷��̾� �Է�
      player_in = $urandom_range(1, 3);
      #10;
      total = total + player_in;
      $display("�÷��̾�: %d, ��������� ��: %d", player_in, total);
      
      // ���� ���� üũ
      if (total >= 31) begin
        if (player_win)
          $display("���� ���� - �÷��̾� �¸�");
        else
          $display("���� ���� - ��ǻ�� �¸�");
        $finish;
      end
      
      // ��ǻ�� �Է�
      #10;
      total = total + comp_in;
      $display("��ǻ��: %d, ��������� ��: %d", comp_in, total);
      
      // ���� ���� üũ
      if (total >= 31) begin
        if (player_win)
          $display("���� ���� - �÷��̾� �¸�");
        else
          $display("���� ���� - ��ǻ�� �¸�");
        $finish;
      end
    end
    
    // ���� �� �����
    #10;
    reset = 1;
    #5 reset = 0;
    
    // ���� ����
    repeat (10) begin
      // �÷��̾� �Է�
      player_in = $urandom_range(1, 3);
      #10;
      total = total + player_in;
      $display("�÷��̾�: %d, ��������� ��: %d", player_in, total);
      
      // ���� ���� üũ
      if (total >= 31) begin
        if (player_win)
          $display("���� ���� - �÷��̾� �¸�");
        else
          $display("���� ���� - ��ǻ�� �¸�");
        $finish;
      end
      
      // ��ǻ�� �Է�
      #10;
      total = total + comp_in;
      $display("��ǻ��: %d, ��������� ��: %d", comp_in, total);
      
      // ���� ���� üũ
      if (total >= 31) begin
        if (player_win)
          $display("���� ���� - �÷��̾� �¸�");
        else
          $display("���� ���� - ��ǻ�� �¸�");
        $finish;
      end
    end
    
    $finish;
  end
  
  always begin
    #5 clk = ~clk;
  end
  
endmodule