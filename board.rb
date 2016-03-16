require_relative 'pieces'
require_relative 'display'

class Board
  class EmptySquareError < StandardError
  end
  class InvalidMoveError < StandardError
  end

  def self.in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySpace.instance } }
  end

  def in_check?(color)
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
    @grid.flatten.reject { |square| square.empty? }
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
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    pieces.each_with_index do |piece, idx|
      piece.new(color, [row, idx], self)
    end
  end

  def generate_pawn_row(color, row)
    8.times do |column|
      Pawn.new(color, [row, column], self)
    end
  end

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
