arr = [0, 1, 5, 7]

# O(n^2)
def bad_two_sum?(arr, target_sum)

  (0...arr.length - 1).each do |i|
    (i + 1...arr.length).each do |j|
      return true if arr[i] + arr[j] == target_sum
    end
  end
  false
end

# O(nlogn) (quicksort is technically O(n^2))
def okay_two_sum?(arr, target_sum)
  sorted = arr.sort

  low, high = 0, arr.length - 1
  until low >= high
    case sorted[low] + sorted[high] <=> target_sum
    when -1
      low += 1
    when 0
      return true
    when 1
      high -= 1
    end
  end
  false
end

# O(n)
def two_sum?(arr, target_sum)
  numbers = Hash.new {|h,k| h[k] = false}
  arr.each { |num| numbers[num] = true }
  arr.each do |num|
    pair = target_sum - num
    next if pair == num
    return true if numbers[pair]
  end
  false
end

# O(n^3)
def four_sum?(arr, target_sum)
  numbers = Hash.new {|h,k| h[k] = false}
  arr.each { |num| numbers[num] = true }
  (0...arr.length - 2).each do |i|
    (i + 1...arr.length - 1).each do |j|
      (j + 1...arr.length).each do |k|
        missing_num = target_sum - arr[i] + arr[j] + arr[k]
        return true if numbers[missing_num] && ![arr[i], arr[j], arr[k]].include?(missing_num)
      end
    end
  end
  false
end


p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false
