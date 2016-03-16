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
  def inspect
    "<#{self.class}, #{@position}, #{@color}>"
  end
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board

    board[*position] = self
  end

  attr_accessor :position
  attr_reader :color

  def moves
  end

  def valid?(new_position)
    Board.in_bounds?(new_position) &&
      @board[*new_position].color != @color
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(position)
    duped_board = @board.dup
    duped_self = duped_board[*@position]

    duped_self.move!(position)

    duped_board.in_check?(@color)
  end

  def move!(new_position)
    @board[*@position] = EmptySpace.instance
    @position = new_position
    @board[*new_position] = self
  end

  def add_delta(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  def empty?
    false
  end
end
