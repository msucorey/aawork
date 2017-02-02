# require_relative 'null_piece'
# require_relative 'board'

class Piece

  attr_accessor :position

  def initialize(board, position = nil, type = nil)
    @board = board
    @position = position
  end



end
