module SteppingPiece

  def moves
    result = []
    move_dirs.each do |el|
      temp = [@position[0] + el[0], @position[1] + el[1]]
      if @board.valid_pos?(temp) && @board.piece_color(temp) != color
        result << temp
      end
    end
    result
  end

end
