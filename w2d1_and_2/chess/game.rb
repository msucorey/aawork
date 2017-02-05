require_relative "board"
require_relative "human_player"
require "byebug"

class Game
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(@board, "player1", :wh)
    @player2 = HumanPlayer.new(@board, "player2", :bl)
  end


  def play
    take_turn
    until @board.game_over?
      switch
      take_turn
    end
  end

  def take_turn
    @current_player ||= @player1
    @current_player.display.render
    color = @current_player.color
    begin
      puts "please enter a starting position"
      start_pos = @current_player.get_input
      if @board[start_pos].is_a?(NullPiece)
        puts "null piece"
        sleep(2)
        raise "nothing in starting position"
      end
      # debuggr

      unless @board.valid_pos?(start_pos)
        puts "invalid position"
        sleep(2)
        raise "Invalid starting position"
      end
      unless @board[start_pos].color == color
        puts "not your piece!"
        sleep(2)
        raise "Invalid color piec"
      end
      puts "please enter an ending position"
      end_pos = @current_player.get_input
      unless @board.valid_pos?(end_pos)
        puts "invalid end"
        sleep(2)
        raise "Invalid ending position"
      end
      unless @board[start_pos].valid_moves.include?(end_pos)

        # p @board[start_pos].valid_moves
        puts "not a valid move"
        sleep(2)
        raise "Invalid move"
      end
      @board.move_piece(start_pos, end_pos)
    rescue
      puts "try again"
    retry
    end

    def switch
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end

  end





end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
