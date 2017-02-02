require_relative 'piece'
require_relative 'null_piece'
require_relative 'display'
require "byebug"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8){Array.new(8){NullPiece.new(self)}}
    @display = Display.new(self)
    setup
  end


  def setup
    #put real pieces where real pieces go and assign their pos's
    #tell all the nullpieces their positions
    @grid[0..1].each_with_index do |row, i|
      row.each_with_index do |square, j|
        @grid[i][j] = Piece.new(grid, [i,j])
      end
    end
    i = 6
    while i < 8
      @grid[6..7].each do |row|
        row.each_with_index do |square, j|
          @grid[i][j] = Piece.new(grid, [i,j])
        end
      end
      i += 1
    end
  end

  def play
    until game_over?
      @display.render
      begin
        puts "please enter a starting position"
        start_pos = get_input
        if self[start_pos].is_a?(NullPiece)
          puts "null piece"
          raise "nothing in starting position"
        end
        unless valid_pos?(start_pos)
          puts "invalid position"
          raise "Invalid starting position"
        end
        puts "please enter an ending position"
        end_pos = get_input
        unless valid_pos?(end_pos)
          puts "invalid end"
                  raise "Invalid ending position"
        end
        move_piece(start_pos, end_pos)
      rescue
        puts "try again"
      retry
      end
    end
  end

  def get_input
    input = nil
    while input.nil?
      input = @display.cursor.get_input
      @display.render
    end
    input.dup
  end

  def game_over?
    false
  end

  def move_piece(start_pos, end_pos)
    #TODO
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.new(self)
  end

  def valid_pos?(pos)
    row = pos[0]
    col = pos[1]
    return true if (row.between?(0,7) && col.between?(0,7))
    false
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    # debugger
    x, y = pos
    @grid[x][y] = val
  end

end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.play
end
