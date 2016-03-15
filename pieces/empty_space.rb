require 'singleton'
class EmptySpace
  include Singleton

  def inspect
    "<EMPTY SPACE>"
  end
  def color
    :green
  end
  attr_accessor :position
  def to_s
    "    "
  end
end
