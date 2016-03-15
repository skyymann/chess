require_relative 'pieces'
require_relative 'display'
require 'byebug'
class Board
  class EmptySquareError < StandardError
  end
  class InvalidMoveError < StandardError
  end

# created for testing purposes
  def Board.in_bounds?(pos)
    return false unless pos[0].between?(0, 7)
    return false unless pos[1].between?(0, 7)

    true
  end

  def Board.empty_board
    grid = []
    8.times { grid << Board.empty_row}
    grid
  end

  def Board.empty_row()
    Array.new(8) { EmptySpace.instance}
  end

  def initialize
    @grid = Board.empty_board
  end

  attr_reader :grid

  def in_check?(color)
    #byebug
    enemy_pieces = pieces - pieces_by_color(color)
    enemy_pieces.any? { |piece| piece.moves.include?(king_pos(color)) }
  end

  def pieces_by_color(color)
    pieces.select { |piece| piece.color == color }
  end

  def checkmate?(color)
    return false unless in_check?(color)
    all_moves = pieces_by_color(color).inject([]) do |all_moves, piece|
      piece.valid_moves + all_moves
    end
    all_moves.empty?
  end

  def dup
    duped_board = Board.new
    pieces.each do |piece|
      piece.class.new(piece.color, piece.position, duped_board)
    end
    duped_board
  end

  def pieces
    @grid.flatten.select { |square| square.is_a?(Piece) }
  end

  def king_pos(color)
    king = pieces.find do |piece|
      piece.color == color && piece.is_a?(King)
    end

    king.position
  end

  def fill_grid
    generate_pieces_row(:black, 0)
    generate_pawn_row(:black, 1)
    generate_pawn_row(:white, 6)
    generate_pieces_row(:white, 7)
  end

  def generate_pieces_row(color, row)
    Rook.new(color, [row, 0], self)
    Knight.new(color, [row, 1], self)
    Bishop.new(color, [row, 2], self)
    Queen.new(color, [row, 3], self)
    King.new(color, [row, 4], self)
    Bishop.new(color, [row, 5], self)
    Knight.new(color, [row, 6], self)
    Rook.new(color, [row, 7], self)
  end

  def generate_pawn_row(color, row)
    8.times do |column|
      Pawn.new(color, [row, column], self)
    end
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

  def inspect
    @grid.each do |row|
      row.each { |el| print el }
      print "\n"
    end
  end
end
