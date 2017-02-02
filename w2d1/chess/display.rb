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
          print ([i,j] == @cursor.cursor_pos)? "_|".red : "_|".blue
        else
          print ([i,j] == @cursor.cursor_pos)? "x|".red : "x|".blue
        end

      end
      puts ""
    end

  end

end
