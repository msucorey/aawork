class Rook < Piece

  attr_reader :color, :type, :position

  include SlidingPiece

  def initialize(board=nil, position = nil, color)
    @board = board
    @position = position
    @color = color
    @type =  :rk
    @direction = [[-1,0],[1,0],[0,1],[0,-1]]
  end

  def move_dirs
    @direction.dup
  end


end
