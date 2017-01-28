require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder

  MOVE_OFFSETS = [[-2,+1], [-2,-1],
                  [-1,+2], [-1,-2],
                  [+1,+2], [+1,-2],
                  [+2,-1], [+2,+1]]

  attr_reader :pos, :tree

  def initialize(pos)
    @pos = pos
    @tree = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    build_move_tree
  end

  def build_move_tree
    queue = [@tree]
    until queue.empty?
      this_node = queue.shift
      new_move_positions(this_node.value).each do |position|
        new_child = PolyTreeNode.new(position)
        this_node.add_child(new_child)
        queue << new_child
      end
    end
  end

  def find_path(end_pos)
    queue = [@tree]
    until queue.empty?
      this_node = queue.shift
      return trace_path_back(this_node) if this_node.value == end_pos
      queue.concat(this_node.children)
    end
    nil
  end

  def trace_path_back(node)
    path = []
    this_node = node
    until this_node.parent.nil?
      path << this_node.value
      this_node = this_node.parent
    end
    path << this_node.value
    path.reverse
  end

  def new_move_positions(pos)
    new_moves = []
    KnightPathFinder.valid_moves(pos).each do |move|
      new_moves << move unless @visited_positions.include?(move)
    end
    @visited_positions.concat(new_moves)
    new_moves
  end

  def self.valid_moves(pos)
    moves = []
    x, y = pos
    MOVE_OFFSETS.each do |offset|
      x_offset, y_offset = offset
      new_x = x + x_offset
      new_y = y + y_offset
      moves << [new_x, new_y] if (new_x).between?(1,8) && (new_y).between?(1,8)
    end
    return moves
  end
end

a = KnightPathFinder.new([1,1])
a.find_path([8,7])
