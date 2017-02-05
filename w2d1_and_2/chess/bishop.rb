class Bishop < Piece

  attr_reader :color, :type, :position
  include SlidingPiece


  def initialize(board=nil, position = nil, color)
    @board = board
    @position = position
    @color = color
    @type =  :bi
    @direction = [[1,1],[-1,1],[-1,-1],[1,-1]]
  end

  def move_dirs
    @direction.dup
  end


end
