module Slideable
  def moves
    moves = []
    directions.each { |direction| moves += find_range(direction) }
    moves
  end

  def find_range(direction)
    range = []
    current_pos = @position.dup

    loop do
      current_pos = add_delta(current_pos, direction)
      break unless valid?(current_pos)

      case @board[*current_pos].color
      when :green
        range << current_pos
      else
        range << current_pos
        break
      end
    end
    range
  end
end
