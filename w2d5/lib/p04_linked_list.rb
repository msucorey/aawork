class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    temp_ptr = @head
    until temp_ptr.key == key || temp_ptr == @tail
      temp_ptr = temp_ptr.next
    end

    temp_ptr == @tail ? nil : temp_ptr.val
  end

  def include?(key)
    temp_ptr = @head
    until temp_ptr.key == key || temp_ptr == @tail
      temp_ptr = temp_ptr.next

    end
    temp_ptr != @tail
  end

  def append(key, val)
    new_item = Link.new(key, val)
    @tail.prev.next = new_item
    new_item.prev = @tail.prev
    @tail.prev = new_item
    new_item.next = @tail
    puts "i just added #{key}"
  end

  def update(key, val)
    temp_ptr = @head
    until temp_ptr.key == key || temp_ptr == @tail
      temp_ptr = temp_ptr.next
    end
    temp_ptr.val = val unless temp_ptr == @tail
  end

  def remove(key)
    return nil if get(key).nil?

    temp_ptr = @head
    until temp_ptr.key == key
      temp_ptr = temp_ptr.next
    end

    puts "i just removed the item with key #{key}"
    temp_ptr.prev.next = temp_ptr.next
    temp_ptr.next.prev = temp_ptr.prev
    puts "my elements are now..."
    self.each { |el| puts el.key }
  end

  def each
    temp_ptr = @head
    test_ctr = 0
    until temp_ptr == @tail
      temp_ptr = temp_ptr.next
      yield(temp_ptr) unless temp_ptr == @tail
      test_ctr += 1 unless temp_ptr == @tail
    end
    puts "my each just got called and i returned #{test_ctr} items"
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
