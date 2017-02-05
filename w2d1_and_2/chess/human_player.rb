class HumanPlayer

  attr_reader :display, :color

  def initialize(board, name, color)
    @name = name
    @color = color
    @display = Display.new(board)
  end


  def get_input
    input = nil
    while input.nil?
      input = @display.cursor.get_input
      @display.render
    end
    input.dup
  end
end
