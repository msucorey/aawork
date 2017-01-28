require_relative 'tile'
require_relative 'board'

class Game

  attr_reader :board

  def initialize(filename)
    @board = Board.new(Board.from_file(filename))
  end

  def play
    until game_over?
    #show the board
      @board.render
    #prompt player for value and position
      input = prompt_player
    #check if valid placement
    #place if valid or return error
    #update the board if valid
    #repeat until the board is solved or dead end reached
  end

  def game_over?
    @board.solved? or @board.cats_game?
  end

  def prompt_player
    valid_input = false
    until valid_input
      puts "give me a value"
      value = gets.chomp
      puts "give me a coordinate"
      input = gets.chomp
      pos = input.split(", ").map(&:to_i)
      valid_input = @board.valid_placement?(value, pos)
    #   unless valid_input
    #     puts "Sorry! Not valid input - try again"
    #     sleep(1)
    #   end
    # end
    # pos

end
