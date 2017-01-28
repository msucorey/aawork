require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :children, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    # @parent = nil
    @children = []
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  def add_child(node)
    @children << node
    node
  end

  def losing_node?(evaluator)
    opponent = (evaluator == :x ? :o : :x)
    return true if board.over? && board.winner == opponent
    return false if (board.winner == evaluator || board.winner.nil?)
    if next_mover_mark == opponent
      @children.all? { |child| child.losing_node?(evaluator) }
    else
      @children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return false unless @board.over?
    return true if @board.winner == evaluator
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |square, j|
        pos = [i,j]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = @next_mover_mark
          mark = (@next_mover_mark == :x ? :o : :x)
          children << add_child(TicTacToeNode.new(new_board, mark, pos))
        end
      end
    end
    children
  end
end
