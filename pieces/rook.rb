class Rook < Piece
  include Slideable
  def to_s
    " ♜  "
  end

  def directions
    LINEAR_DELTAS
  end
end
