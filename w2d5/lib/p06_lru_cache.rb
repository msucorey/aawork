require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    puts count
    if @map.include?(key)
      update_link!(key)
      return @store[key].val
    else
      val = @prc.call(key)
      eject! if count == @max
      puts "calling append from the get else statement"
      @store.append(key, val)

      @map.set(key, @store[key])
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(key)
    #store the value that exists on the linked for this key
    #call remove on the linked list with this key
    #call append on the linked list with this key and value
    val = @store[key]
    @store.remove(@store[key])
    puts "calling append from update line"
    @store.append(key, val)
  end

  def eject!
    #call remove for linked list.first(oldest)
    #remove key from hash map
    key = @store.first.key
    p @store.first
    @store.remove(key)
    @map.delete(key)
  end
end
