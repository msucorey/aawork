class Pawn < Piece

  attr_reader :color, :type, :position

  def initialize(board=nil, position = nil, color)
    @board = board
    @position = position
    @color = color
    @type =  :pa
    @direction = set_direction
  end

  def set_direction
    (@color == :wh) ? [[-1,-1],[-1,0],[-1,1]] : [[1,-1],[1,0],[1,1]]
  end
#
  def move_dirs
    @direction.dup
  end
require 'byebug'
  def moves
    result = []
    straight = false
    other_color = (color == :wh) ? :bl : :wh

    move_dirs.each do |el|
      temp = [@position[0] + el[0], @position[1] + el[1]]
      straight = (el[1] == 0)
      if @board.valid_pos?(temp) && (@board.piece_color(temp) == nil) && straight
        result << temp
      elsif @board.valid_pos?(temp) && (@board.piece_color(temp) == other_color) && !straight
        result << temp
      end
    end
    result

  end

end

# def moves
#   result = []
#   move_dirs.each do |el|
#     temp = [@position[0] + el[0], @position[1] + el[1]]
#     if @board.valid_pos?(temp) && @board.piece_color(temp) != color
#       result << temp
#     end
#   end
#   result
# end
