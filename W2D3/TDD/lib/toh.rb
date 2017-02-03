class TowersofHanoi

  attr_accessor :towers

  def initialize(towers = nil)
    towers.nil? ? populate_board(3) : @towers = towers
    # @disks = disks
  end

  def populate_board(disks)
    @towers = Array.new(3) { [] }
    (1..disks).each do |i|
      @towers[0].unshift(i)
    end
  end

  def move(string=nil)
    if string.nil?
      p "Please enter a move like: '#,#'"
      string = STDIN.gets.chomp
    end
      start, ending = string.split(",").map(&:to_i)

    unless @towers[ending].empty?
      raise "incorrect move" if @towers[start].last > @towers[ending].last
    end

    @towers[ending] << @towers[start].pop
  end

  def won?
    return false if @towers[0].any?

    if state = @towers.map {|el| el.size }.count {|el| el == 0} == 2
      return true
    end

    false
  end

  def display
    p "#{@towers}"
  end

end

if __FILE__ == $PROGRAM_NAME
  game = TowersofHanoi.new

  until game.won?
    game.move
    game.display
  end
end
