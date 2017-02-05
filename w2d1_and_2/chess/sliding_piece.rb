require "byebug"
module SlidingPiece
  def moves
    result = []

    move_dirs.each do |offset|
      7.times do |i|
        temp = [offset[0] * (i + 1) +@position[0], offset[1] * (i + 1) + @position[1]]
        if @board.valid_pos?(temp) && @board.piece_color(temp) == nil
          result << temp
        elsif  @board.valid_pos?(temp) && @board.piece_color(temp) != color
          result << temp
          break
        else
          break
        end

      end
    end
    result
  end

end
