require_relative 'card'

class Board

  attr_reader :cards, :size

  def initialize(size = 4)
    @size = size.even? ? size : size + 1
    @cards = Array.new(@size) { Array.new(@size) { Card.new } }
    populate
  end

  def populate
    #populate should fill the board with a set of shuffled Card pairs

    values = all_shuffled_face_values
    self.each_card{ |card| card.face_value = values.pop}
  end

  def flip_up(*pos)
    pos.each do |position|
      self[position].face_down = false
    end
  end

  def flip_down(*pos)
    pos.each do |position|
      self[position].face_down = true
    end
  end

  def each_card(&prc)
    @cards.each do |row_arr|
      row_arr.each do |card|
        prc.call(card)
      end
    end
  end

  def all_shuffled_face_values
    values = []
    num_values = (@size ** 2) / 2
    num_values.times do |i|
      values << i << i
    end
    values.shuffle
  end

  def render
    #render should print out a representation of the Board's current state
    system("clear")
    counter = 0
    array = []
    line = "--" * @size
    puts line
    self.each_card do |card|
      if card.face_down?
        array << " "
      else
        array << "#{card.face_value}"
      end
      if array.length == @size
        puts "|#{array.join("|")}|"
        puts line
        array = []
      end
    end
  end

  def won?
    #won? should return true if all cards have been revealed
    return true if @cards.flatten.none?(&:face_down)
    false
  end

  def match?(pos1, pos2)
    self[pos1].face_value == self[pos2].face_value
  end

  def reveal
    # #reveal should reveal a Card at guessed_pos (unless it's already
    # face-up, in which case the method should do nothing). It should
    #   also return the value of the card it revealed (you'll see why
    #   later)
  end

  def [](pos)
    row, col = pos
    @cards[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @cards[row][col] = value
  end

end
