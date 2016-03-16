class Knight < Piece
  include Steppable
  KNIGHT_DELTAS = [
    [1,   2],
    [1,  -2],
    [2,   1],
    [2,  -1],
    [-1,  2],
    [-1, -2],
    [-2,  1],
    [-2, -1]
  ]

  def to_s
    " ♞ "
  end

  def deltas
    KNIGHT_DELTAS
  end
end
