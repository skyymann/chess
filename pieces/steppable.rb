module Steppable
  def moves
    moves = deltas.map { |delta| add_delta(@position, delta) }
    moves.select { |move| valid?(move) }
  end
end
