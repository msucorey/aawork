require_relative 'board'

class HumanPlayer
  attr_reader :name, :board
  attr_accessor :points

  def initialize(name)
    @name = name
    @board = nil
    @points = 0
  end

  def take_turn(board)
    @board = board
    # show board
    # prompt player and get first card from player
    @board.render
    first_card_pos = get_input
    @board.flip_up(first_card_pos)
    # turn over card
    # reveal board to player
    @board.render
    # get second card from player
    second_card_pos = get_input
    # turn over card
    @board.flip_up(second_card_pos)
    # reveal board to player
    @board.render
    sleep(1)


    # if match, leave cards exposed and score 2 points for player
    [first_card_pos, second_card_pos]
  end

  def prompt
    puts "Hey #{@name}, pick a card to flip by coordinates like \"1, 2\" for position
           [1, 2]"
  end
# require "byebug"
  def get_input
    valid_input = false
    until valid_input
      prompt
      input = gets.chomp
      pos = input.split(", ").map(&:to_i)
      valid_input = valid_input?(pos)
      unless valid_input
        puts "Sorry! Not valid input"
        sleep(1)
      end
    end
    pos
  end

  def check_coord
  end

  def valid_input?(pos)
    pos.all?{|x| x.is_a?(Integer) && x <= @board.size - 1}
  end

end
