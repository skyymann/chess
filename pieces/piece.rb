class Piece

  LINEAR_DELTAS = [
    [1,0],
    [-1,0],
    [0,1],
    [0,-1]
  ]

  DIAG_DELTAS = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  attr_accessor :position
  attr_reader :color

  def moves
  end

  def valid?(new_position)
    Board.in_bounds?(new_position) &&
      @board[*new_position].color != @color
  end

  def add_delta(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end
end
