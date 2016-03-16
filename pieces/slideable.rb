module Slideable
  def moves
    moves = []
    directions.each { |direction| moves += find_range(direction) }
    moves
  end

  def find_range(direction)
    range = []
    current_pos = @position

    loop do
      current_pos = add_delta(current_pos, direction)
      break unless valid?(current_pos)

      range << current_pos
      break unless @board[*current_pos].empty?
    end

    range
  end
end
