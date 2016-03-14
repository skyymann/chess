require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable

  def initialize(board)
    @cursor = [0,0]
    @selected = false
    @board = board
  end

  def render
    system("clear")
    puts "Arrow keys to move, enter to confirm"
    build_grid.each { |row| puts row.join }
    nil
  end

  def build_grid
    @board.grid.map.with_index do |row, row_idx|
      build_row(row, row_idx)
    end
  end

  def build_row(row, row_idx)
    row.map.with_index do |square, col_idx|
      color_options = colors_for(row_idx, col_idx)
      square.to_s.colorize(color_options)
    end
  end

  def colors_for(row_idx, col_idx)
    if [row_idx, col_idx] == @cursor
      bg = :light_red
    elsif (row_idx + col_idx).odd?
      bg = :blue
    else
      bg = :light_blue
    end

    { background: bg, color: @board[row_idx, col_idx].color }
  end
end
