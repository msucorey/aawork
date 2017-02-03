require 'byebug'

class Array

  def my_uniq
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end
    result
  end

  def two_sum
    result = []
    self.each_with_index do |el, i|
      j = i + 1
      while j < self.length
        result << [i, j] if el + self[j] == 0
        j += 1
      end
    end
    result
  end

  def my_transpose
    result = Array.new(size) { Array.new (size)}

    self.each_with_index do |row, i|
      row.each_with_index do |el, j|
        result[i][j] = self[j][i]
      end
    end

    result
  end

  def stock_picker
    max = 0
    max_coords = []
    self.each_with_index do |el, i|
      j = i + 1
      # byebug
      if i == 0 && j == 1
        max = self[j] - el
        max_coords = [i, j]
      end

      while j < self.length - 1
        this_profit = self[j] - el
        # p this_profit
        if this_profit > max
          max = this_profit
          max_coords = [i, j]
        end

        j += 1
      end
    end
    max_coords
  end
end
