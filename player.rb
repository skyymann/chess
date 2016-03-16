class NotYourPieceError < ArgumentError
end

class InvalidMoveError < ArgumentError
end

class NoValidMovesError < ArgumentError
end

class Player
  attr_accessor :color
  attr_reader :name, :display

  def initialize(name)
    @name = name
  end

  def board=(board)
    @board = board
    @display = Display.new(board)
  end

  def take_turn
    piece = select_piece
    target = select_target(piece)
    piece.move!(target)
  end

  def get_position(message)
    position = nil
    until position
      @display.render
      puts message
      position = @display.get_input
    end
    position
  end

  def select_piece
    begin
      message = "Your turn #{@name}.\nPlease select a piece"
      position = get_position(message)
      piece = @board[*position]
      if piece.color != @color
        raise NotYourPieceError.new("That's not your piece!")
      elsif piece.valid_moves.empty?
        raise NoValidMovesError.new("No valid moves for that piece!")
      end

    rescue NoValidMovesError, NotYourPieceError => e
      puts e
      sleep(2)
    retry
    end

    @display.selected_pos = position
    @display.selected_pos_moves = @board[*position].valid_moves
    piece
  end

  def select_target(piece)
    begin
      message = "Your turn #{@name}.\nMove to where?"
      position = get_position(message)
      unless piece.valid_moves.include?(position)
        raise InvalidMoveError.new("You can't move there!")
      end

    rescue InvalidMoveError => e
      puts e
      sleep(2)
    retry
    end

    @display.selected_pos = nil
    @display.selected_pos_moves = nil
    position
  end
end
