# require_relative 'null_piece'
# require_relative 'board'
require "byebug"
class Piece

  attr_accessor :position
  attr_reader :color, :type

  def initialize(board = nil, position = nil, color = nil, type = :xx)
    @board = board
    @position = position
    @color = color
    @type = type
  end



  def valid_moves
    # debugger
    puts "about to go into incheck loop"
    sleep(1)
    puts "right now position is " + @position.to_s
    unless @board.in_check?(color)
      temp = moves
      return temp
    end
    result = []
    moves.each do |move|
      result << move unless move_into_check?(move)
    end
    result
  end

  def move_into_check?(end_pos)
    copy = @board.deep_dup
    copy.move_piece(position, end_pos)
    copy.in_check?(color)
  end

end
