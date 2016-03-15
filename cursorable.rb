require 'io/console'
require 'byebug'
module Cursorable
  KEYMAP = {
    "w" => :up,
    "s" => :down,
    "d" => :right,
    "a" => :left,
    "\r"   => :return,
    "\u0003" => :ctrl_c
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }
  def test_play
    loop do
      render
      get_input
    end
  end

  def get_input
  #  debugger
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr

    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def handle_key(key)
    case key
    when :ctrl_c then exit 0
    when :return then @cursor
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    end
  end

  def update_pos(delta)
    new_pos = [@cursor[0] + delta[0], @cursor[1] + delta[1]]
    @cursor = new_pos if Board.in_bounds?(new_pos)
  end

end
