class Knight < Piece

  attr_reader :color, :type, :position

  include SteppingPiece

  def initialize(board=nil, position = nil, color)
    @board = board
    @position = position
    @color = color
    @type =  :kn
    @direction = [[-1,2], [-2,1], [-2,-1], [-1,-2], [1,-2], [2,-1], [2,1], [1,2]]
  end

  def move_dirs
    @direction.dup
  end


end
