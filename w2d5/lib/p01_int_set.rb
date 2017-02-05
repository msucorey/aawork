class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if @store[num] || !num.between?(0, @max)
    @store[num] = true
  end

  def remove(num)
    # raise "Out of bounds" if @store[num]
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].reject! { |el| el == num }
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end
  #O(1)
  def insert(num)
    resize! if @count == num_buckets
    self[num] << num
    @count += 1
  end
  #O(1)
  def remove(num)
    self[num].reject! { |el| el == num }
    @count -= 1
  end
  #O(1)
  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
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
