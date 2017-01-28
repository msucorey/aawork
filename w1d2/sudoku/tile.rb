require_relative 'game'
require_relative 'board'

class Tile

  attr_reader :value, :given, :position

  def initialize(value, pos)
    @value = value
    @given = value == 0 ? false : true
    @position = pos
  end

end
