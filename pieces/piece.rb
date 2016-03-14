class Piece
  def initialize(color, position)
    @color = color
    @position = position
  end

  attr_accessor :position
  attr_reader :color
end
