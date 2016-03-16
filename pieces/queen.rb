class Queen < Piece
  include Slideable
  def to_s
    " ♛ "
  end

  def directions
    DIAG_DELTAS + LINEAR_DELTAS
  end
end
