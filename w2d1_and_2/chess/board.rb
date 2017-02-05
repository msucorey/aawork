require_relative "stepping_piece"
require_relative "sliding_piece"
require_relative 'piece'
require_relative 'null_piece'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'queen'
require_relative 'rook'
require_relative 'display'
require_relative 'pawn'



require "byebug"

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8){Array.new(8){NullPiece.instance}}
    @display = Display.new(self)
    setup
  end


  def setup
    #put real pieces where real pieces go and assign their pos's
    #tell all the nullpieces their positions
    # template = [[:ro, :kn, :bi, :qu, :ki, :bi, :kn, :ro],
    #             [:pa,:pa,:pa,:pa,:pa,:pa,:pa,:pa],
    #             [],[],[],[],
    #             [  :pa,:pa,:pa,:pa,:pa,:pa,:pa,:pa ],
    #             [:ro, :kn, :bi, :qu, :ki, :bi, :kn, :ro]]
    # @grid[0..1].each_with_index do |row, i|
    #   row.each_with_index do |square, j|
    #     case template[i,j]
    #     when :ro
    #       @grid[i][j] = Rook.new(grid, [i,j], :bl)
    #     when :kn
    #       @grid[i][j] = Knight.new(grid, [i,j], :bl)
    #     when :bi
    #       @grid[i][j] = Bishop.new(grid, [i,j], :bl)
    #     when :qu
    #       @grid[i][j] = Queen.new(grid, [i,j], :bl)
    #     when :ki
    #       @grid[i][j] = King.new(grid, [i,j], :bl)
    #     when :pa
    #       @grid[i][j] = Piece.new(grid, [i,j], :bl)
    #     end
    #   end
    # end
    # i = 6
    # while i < 8
    #   @grid[6..7].each do |row|
    #     row.each_with_index do |square, j|
    #       case template[i,j]
    #       when :ro
    #         @grid[i][j] = Rook.new(grid, [i,j], :wh)
    #       when :kn
    #         @grid[i][j] = Knight.new(grid, [i,j], :wh)
    #       when :bi
    #         @grid[i][j] = Bishop.new(grid, [i,j], :wh)
    #       when :qu
    #         @grid[i][j] = Queen.new(grid, [i,j], :wh)
    #       when :ki
    #         @grid[i][j] = King.new(grid, [i,j], :wh)
    #       when :pa
    #         @grid[i][j] = Piece.new(grid, [i,j], :wh)
    #       end
    #     end
    #   end
    #   i += 1
    # end
    # template = [[:ro, :kn, :bi, :qu, :ki, :bi, :kn, :ro],

      # @grid[0][0] = Rook.new([0,0], :bl)
    @grid[0] = [Rook.new(self,[0,0], :bl), Knight.new(self,[0,1], :bl), Bishop.new(self,[0,2], :bl),
                Queen.new(self,[0,3], :bl), King.new(self,[0,4], :bl), Bishop.new(self,[0,5],:bl), Knight.new(self,[0,6], :bl), Rook.new(self,[0,7], :bl)]
    @grid[1].each_with_index do |square,idx|
      @grid[1][idx] = Pawn.new(self,[1,idx],:bl)
    end
    @grid[7] = [Rook.new(self,[7,0], :wh), Knight.new(self,[7,1], :wh), Bishop.new(self,[7,2], :wh),
                Queen.new(self,[7,3], :wh), King.new(self,[7,4], :wh), Bishop.new(self,[7,5],:wh), Knight.new(self,[7,6], :wh), Rook.new(self,[7,7], :wh)]
    @grid[6].each_with_index do |square,idx|
      @grid[6][idx] = Pawn.new(self,[6,idx],:wh)
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
      self[start_pos] = NullPiece.instance
      self[end_pos].position = end_pos
  end

  def valid_pos?(pos)
    row = pos[0]
    col = pos[1]
    return true if (row.between?(0,7) && col.between?(0,7))
    false
  end

  def in_check?(color)
    king = find_king(color)
    king_pos = king.position
    other_color = (color == :wh)? :bl : :wh
    @grid.each do |row|
      row.each do |square|
        return true if (square.color == other_color) && (square.moves.include?(king_pos))
      end
    end

    false
  end

  def checkmate?(color)
    return false unless in_check?(color)
    @grid.each do |row|
      row.each do |square|
        return false if (square.color == color) && (!square.valid_moves.empty?)
      end
    end

    true
  end

  def game_over?
    return true if checkmate?(:wh) || checkmate?(:bl)
  end



  def find_king(color)
    @grid.each do |row|
      row.each do |square|
        if square.is_a?(King) && square.color == color
          return square
        end
      end
    end
  end

  def piece_color(pos)
    row = pos[0]
    col = pos[1]
    # debugger
    @grid[row][col].color
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

  def deep_dup
    grid_copy = Array.new(8){Array.new(8){NullPiece.instance}}
    @grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        type = @grid[i][j].type
        color = @grid[i][j].color
        case type
        when :ki
          grid_copy[i][j] = King.new(grid_copy, [i,j], color)
        when :qu
          grid_copy[i][j] = Queen.new(grid_copy, [i,j], color)
        when :ro
          grid_copy[i][j] = Rook.new(grid_copy, [i,j], color)
        when :bi
          grid_copy[i][j] = Bishop.new(grid_copy, [i,j], color)
        when :kn
          grid_copy[i][j] = Knight.new(grid_copy, [i,j], color)
        when :pa
          grid_copy[i][j] = Pawn.new(grid_copy, [i,j], color)
        end
      end
    end
    grid_copy
  end

end




if __FILE__ == $PROGRAM_NAME
  b = Board.new
  # b.play
  b.grid[7][4] = NullPiece.instance
  king = King.new(b, [3,0], :wh)
  b.grid[3][0] = king
  d = Display.new(b)
  d.render
  p b.in_check?(:wh)
end
