require 'rspec'
require 'toh'

describe "Towers of Hanoi: The Game" do
  subject(:game) {TowersofHanoi.new}

  describe "#initalize" do
    it "sets up 3 towers (i.e. subarrays inside an array)" do
      expect(game.towers.size).to eq(3)
    end

    it "sets all disks onto one tower" do
      result = game.towers.size_map.count { |el| el == 0}
      expect(result).to eq(2)
    end

    it "sets other two towers to empty" do
      result = game.towers.size_map.count { |el| el == 0}
      expect(result).to eq(2)
    end

  end

  describe "#move" do
    it "takes two towers as arguments" do
      expect(game).to respond_to(:move).with(1).argument
    end

    it "raises an exception if the starting tower's disk is larger than
    the destination tower's top disk" do
      game.move("0,2")
      expect {game.move("0,2")}.to raise_error("incorrect move")
    end

    it "updates the board based on the move" do
      game.move("0,2")
      expect(game.towers[2]).to eq([1])
    end

  end

  describe "#won?" do
    let(:winning_board) {TowersofHanoi.new([[], [3, 2, 1], []])}
    let(:test_board) {TowersofHanoi.new([[1], [3, 2], []])}
    
    it "returns true if all of the disks are on one tower that isnt the
    starting tower" do
      expect(winning_board.won?).to be true
    end

    it "returns false if there is a disk on a starting tower" do
      expect(test_board.won?).to be false
    end

    it "returns false if there are disks on multiple towers" do
      expect(test_board.won?).to be false
    end

  end

  describe "#display" do
    let(:test_board) {TowersofHanoi.new([[1], [3, 2], []])}

    it "outputs a graphical representation of board state" do
      expect(test_board.display).to eq("[[1], [3, 2], []]")
    end
  end

end

class Array
  def size_map
    self.map {|el| el.size }
  end
end
