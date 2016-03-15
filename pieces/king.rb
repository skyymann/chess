class King < Piece
  include Steppable
  def to_s
    " ♚  "
  end

  def deltas
    LINEAR_DELTAS + DIAG_DELTAS
  end
end
