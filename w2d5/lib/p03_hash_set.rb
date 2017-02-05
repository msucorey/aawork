require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  #O(1)
  def insert(item)
    num = item.hash
    resize! if @count == num_buckets
    self[num] << num
    @count += 1
  end
  #O(1)
  def remove(item)
    num = item.hash
    self[num].reject! { |el| el == num }
    @count -= 1
  end
  #O(1)
  def include?(item)
    num = item.hash
    self[num].include?(num)
  end

  private

  def [](item)
    num = item.hash
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_array = []
    @store.each do |el|
      el.each do |value|
        temp_array << value
      end
    end
    @store = Array.new(2 * num_buckets) { Array.new }

    old_size = temp_array.size
    temp_array.each do |el|
      insert(el)
    end

    @count -= old_size
  end
end
