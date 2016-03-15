require_relative 'board'
require_relative 'player'

class Chess
  def initialize(player1, player2)
    @cur_player = player1
    @prev_player = player2
  end

  def setup
    @board = Board.new
    @board.fill_grid
    @cur_player.color, @prev_player.color = :white, :black
    @cur_player.board = @prev_player.board = @board
  end

  def play
    until game_over?
      @cur_player.take_turn
      switch_players!
    end
    
    @prev_player.display.render
    puts "Congratulations #{@prev_player.name}! You win!"
  end

  def switch_players!
    @cur_player, @prev_player = @prev_player, @cur_player
  end

  def game_over?
    @board.checkmate?(@cur_player.color)
  end
end
