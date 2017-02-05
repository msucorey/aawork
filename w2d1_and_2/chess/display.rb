require 'colorize'
require_relative 'cursor'
require "byebug"
class Display

  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([2,2], board)
  end

  def test_loop
    while true
      @cursor.get_input
      render
    end
  end

  def render
    system("clear")
    @board.grid.each_with_index do |row, i|
      print "|".blue
      row.each_with_index do |square, j|
        if square.is_a?(NullPiece)
          print ([i,j] == @cursor.cursor_pos)? "__".red : "__".blue
        else
          symbol = square.type.to_s
          
          if [i,j] == @cursor.cursor_pos
            print "#{symbol}".red
          elsif square.color == :bl
            print "#{symbol}".blue
          else
            print "#{symbol}".green
          end
        end
        print "|".blue
      end
      puts ""
    end

  end

end
