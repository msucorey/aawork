require 'rspec'
require 'TDD'

describe "TDD" do
  describe "#my_uniq" do
    subject(:array) { [1, 2, 1, 3, 3] }
    let(:empty_array) { Array.new }

    it "returns an array" do
      expect(array.my_uniq).to be_an(Array)
    end

    it "returns an empty array if given an empty array" do
      expect(empty_array.my_uniq).to be_empty
    end

    it "returns unique elements in an array" do
      expect(array.my_uniq).to match_array([2, 3, 1])
    end

    it "returns unique elements in the way that they appear" do
      expect(array.my_uniq).to eq([1, 2, 3])
    end

  end

  describe "#two_sum" do
    subject(:array) { [-1, 0, 2, -2, 1] }
    let(:small_array) { [2] }

    it "returns an empty array if given an array with less than two
    elements" do
      expect(small_array.two_sum).to be_empty
    end

    it "it returns an array of pairs" do
      array.two_sum.map{ |el| el.size }.all? { |el| expect(el).to eq(2) }
    end

    it "finds pairs that sum to 0" do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "doesn't return pairs that do not sum to 0" do
      result = array.two_sum.map { |el| el.map { |x| array[x] }.inject(:+) }.
      all? { |el| el == 0 }
      expect(result).to be true
    end

    it "returns the results sorted by array index significance" do
      expect(array.two_sum).to eq(array.two_sum.sort)
    end
  end

  describe "#my_transpose" do
    subject(:rows) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:columns) { [[0, 3, 6], [1, 4, 7], [2, 5, 8]]}

    it "returns an array of equal size to given array" do
      expect(rows.my_transpose.size).to eq(rows.size)
    end

    it "returns subarrays of equal size to original subarrays" do
      original_size = rows.size_map
      result = rows.my_transpose.size_map

      expect(result).to eq(original_size)
    end

    it "returns nth subarray with each index coming from nth
    position of original subarrays" do
      expect(rows.my_transpose).to eq(columns)
    end

  end

  describe "#stock_picker" do
    subject(:stock_hist) { [1, 3, 6, 2, 5]}
    let(:bear_mkt) { [10, 9, 7, 4, 1]}

    it "returns an array of length 2" do
      expect(stock_hist.stock_picker.size).to eq(2)
    end

    it "returns sorted array" do
      expect(stock_hist.stock_picker).to eq(stock_hist.stock_picker.sort)
    end

    it "given a fluctuating market, returns a pair of days that
    yield a profit" do
      profit = stock_hist[stock_hist.stock_picker[1]] -
                      stock_hist[stock_hist.stock_picker[0]]
      expect(profit).to be > 0
    end

    it "given a declining market, returns a pair of days that
    minimize the loss" do
      expect(bear_mkt.stock_picker).to eq([0, 1])
    end

    it "outputs the most profitable pair of days on which to first
    buy the stock and then sell the stock" do
      expect(stock_hist.stock_picker).to eq([0, 2])
    end
  end

end

#----- Helper Methods for my_transpose
class Array
  def size_map
    self.map {|el| el.size }
  end
end
