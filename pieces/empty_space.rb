require 'singleton'
class EmptySpace
  include Singleton
  attr_accessor :position

  def inspect
    "<EMPTY SPACE>"
  end

  def color
    :green
  end


  def to_s
    "   "
  end

  def empty?
    true
  end
end
