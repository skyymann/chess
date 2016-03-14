require_relative 'pieces'

class Board
  class EmptySquareError < StandardError
  end
  class InvalidMoveError < StandardError
  end

  def Board.default_grid
    grid = []
    grid << Board.pieces_row(:black, 0)
    grid << Board.pawn_row(:black, 1)
    4.times { grid << Board.empty_row}
    grid << Board.pawn_row(:white, 6)
    grid << Board.pieces_row(:white, 7)
  end

  def Board.pieces_row(color, row)
    [Rook.new(color, [row, 0]),
     Knight.new(color, [row, 1]),
     Bishop.new(color, [row, 2]),
     Queen.new(color, [row, 3]),
     King.new(color, [row, 4]),
     Bishop.new(color, [row, 5]),
     Knight.new(color, [row, 6]),
     Rook.new(color, [row, 7])]
  end

  def Board.pawn_row(color, row)
    pawn_row = []
    8.times do |column|
      pawn_row << Pawn.new(color, [row, column])
    end
    pawn_row
  end

  def Board.empty_row()
    Array.new(8) { EmptySpace.new }
  end

  def initialize()
    @grid = Board.default_grid
  end

  attr_reader :grid

  def self.in_bounds?(pos)
    return false unless pos[0].between?(0, 7)
    return false unless pos[1].between?(0, 7)

    true
  end

  def move(start, end_pos)
    #TO DO: rescue errors from any block that calls Board#move

    if grid[*start].nil?
      raise EmptySquareError("There's no piece there!")
    end

    unless grid[*start].positions.include?(end_pos)
      raise InvalidMoveError("You can't move there!")
    end

    grid[*end_pos] = grid[*start]
    grid[*start] = nil
    grid[*end_pos].position = end_pos
  end

  
  attr_reader :grid
  def [](row, column)
    grid[row][column]
  end

  def []=(row, column, el)
    grid[row][column] = el
  end
end
