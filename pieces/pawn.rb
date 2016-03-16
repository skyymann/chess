class Pawn < Piece
  include Steppable

  def to_s
    " ♟ "
  end

  def deltas
    default_delta + first_move_delta + attack_deltas
  end

  def default_delta
    unoccupied?(one_forward) ? [one_forward] : []
  end

  def unoccupied?(delta)
    @board[*add_delta(@position, delta)].color == :green
  end

  def one_forward
    @color == :white ? [-1, 0] : [1, 0]
  end

  def first_move_delta
    two_forward = add_delta(one_forward, one_forward)

    if unmoved? && unoccupied?(one_forward) && unoccupied?(two_forward)
      [two_forward]
    else
      []
    end
  end

  def attack_deltas
    [[one_forward.first, 1], [one_forward.first, -1]].select do |delta|
      valid_attack?(delta)
    end
  end

  def valid_attack?(delta)
    targeted_square = add_delta(@position, delta)
    valid?(targeted_square) && !@board[*targeted_square].empty?
  end

  def unmoved?
    (@color == :white && @position[0] == 6) ||
      (@color == :black && @position[0] == 1)
  end
end
