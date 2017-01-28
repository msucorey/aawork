require_relative 'card'
require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :current_player, :players

  def initialize(board_size, *players)
    @players = players.map { |player| HumanPlayer.new (player) }
    @current_player = @players.sample
    @board = Board.new(board_size)
  end

  def play
    until board.won?
      first_card_pos, second_card_pos = @current_player.take_turn(@board)
      # if match then keep up on board
      # else turn face down on board
      # if no match, turn cards back over
      puts "the positions are " + first_card_pos.to_s + " and " + second_card_pos.to_s
      sleep(1)
      if board.match?(first_card_pos, second_card_pos)
        @current_player.points += 2
        puts "congrats #{@current_player.name}, you scored 2 points"
        puts "your score is now #{@current_player.points}"
        sleep(1)
      else
        board.flip_down(first_card_pos, second_card_pos)
      end
      # switch players inplay game if more players
      switch_players
    end
  end

  def switch_players
    current_i = @players.index { |player| player == @current_player }
    next_i = current_i == (@players.length - 1) ? 0 : current_i + 1
    @current_player = @players[next_i]
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(4, "jane", "joe")
  game.play
end
