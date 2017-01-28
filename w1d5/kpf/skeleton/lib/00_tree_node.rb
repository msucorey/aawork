class PolyTreeNode
  attr_accessor :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  # Write add_child(child_node) and remove_child(child_node) methods.
  #  These methods should be one- or two-liners that call #parent=.

  def add_child(node)
    @children << node unless @children.include?(node)
    node.parent = self
  end

  def remove_child(node)
    raise "not a child" unless @children.include?(node)
    return unless @children.include?(node)
    @children -= [node]
    node.parent = nil
  end

  def value
    @value
  end
require 'byebug'
  def parent=(node)
    if node.nil?
      @parent.children -= [self] unless @parent == nil
      @parent = nil
    elsif @parent.nil? && !node.nil?
      @parent = node
      node.children << self unless node.children.include?(self)
    else
      @parent.children -= [self]
      @parent = node
      node.children << self unless node.children.include?(self)
    end
  end

#   Write a #dfs(target_value) method which takes a value to
#   search for and performs the search. Write this recursively.
# First, check the value at this node. If a node's value
# matches the target value, return the node.
# If not, iterate through the #children and repeat.
  def dfs(target)
    return self if @value == target
    @children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      node = queue.shift
      result = node.value
      return node if result == target
      queue += node.children
    end
    nil
  end

end
# Write a #bfs(target_value) method to implement breadth first search.
# You will use a local Array variable as a queue to implement this.
# First, insert the current node (self) into the queue.
# Then, in a loop that runs until the array is empty:
# Remove the first node from the queue,
# Check its value,
# Push the node's children to the end of the array.
# # Write a class with four methods:
# # An #initialize(value) method that sets the value, and starts parent as nil,
# # and children to an empty array.
# # A #parent method that returns the node's parent.



# A #children method that returns an array of children of a node.
# A #value method that returns the value stored at the node.
# Write a #parent= method which (1) sets the parent property and (2) adds the
# node to their parent's array of children (unless we're setting parent to nil).
