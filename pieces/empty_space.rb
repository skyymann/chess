require 'singleton'
class EmptySpace
  include Singleton

  def color
    :green
  end
  attr_accessor :position
  def to_s
    "    "
  end
end
