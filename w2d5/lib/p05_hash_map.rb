require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    if include?(key)
      @store[bucket(key)].update(key, val)
    else
      puts "calling append from hash map class"
      @store[bucket(key)].append(key, val)
      @count += 1
    end
  end

  def get(key)
    if include?(key)
      @store[bucket(key)].get(key)
    else
      nil
    end
  end

  def delete(key)
    if include?(key)
      @store[bucket(key)].remove(key)
      @count -= 1
    else
      nil
    end
  end

  def each
    @store.each do |list|
      list.each do |item|
        yield(item.key, item.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_array = []
    @store.each do |el|
      el.each do |pointer|
        temp_array << [pointer.key, pointer.val]
      end
    end

    @store = Array.new(2 * num_buckets) { LinkedList.new }

    old_size = temp_array.size
    p temp_array
    temp_array.each do |k, v|
      set(k, v)
    end

    @count -= old_size

    # self.each do |k, v|
    #   puts v
    # end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
