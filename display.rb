require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable

  def initialize(board)
    @cursor = [0,0]
    @selected_pos = nil
    @board = board
  end

  attr_writer :selected_pos

  def render
    system("clear")
    puts "WASD keys to move, enter to confirm"
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
    if (row_idx + col_idx).odd?
      bg = :blue
    else
      bg = :light_blue
    end

    if @selected_pos
      bg = :light_green if [row_idx, col_idx] == @selected_pos
      if @board[*@selected_pos].valid_moves.include?([row_idx, col_idx])
        bg = :yellow
      end
    end

    if [row_idx, col_idx] == @cursor
      bg = :light_red
    end

    { background: bg, color: @board[row_idx, col_idx].color }
  end


end
