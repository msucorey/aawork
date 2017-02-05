class King < Piece

  attr_reader :color, :type, :position

  include SteppingPiece

  def initialize(board=nil, position = nil, color)
    @board = board
    @position = position
    @color = color
    @type =  :ki
    @direction = [[-1,0],[1,0],[0,1],[-1,0],[1,1],[-1,1],[-1,-1],[1,-1]]
  end

  def move_dirs
    @direction.dup
  end


end
