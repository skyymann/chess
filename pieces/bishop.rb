class Bishop < Piece
  include Slideable
  def to_s
    " ♝ "
  end

  def directions
    DIAG_DELTAS
  end
end
