#recursive

def range_rec(start, finish)
  return [] if finish < start
  return [start] if start == finish
  return [start, finish] if start + 1 == finish
  [start] + range_rec(start + 1, finish)
end

def sum_range_rec(arr)
  return 0 if arr.length.zero?
  return arr[0] if arr.length == 1
  arr[0] + sum_range_rec(arr[1..-1])
end

def sum_range_it(arr)
  arr.inject(:+)
end

def exponentiate_1(base, exp)
  return 1 if exp == 0
  base * exponentiate_1(base, exp - 1)
end

def exponentiate_2(base, exp)
  return 1 if exp == 0
  if exp.even?
    return exponentiate_2(base, exp / 2) ** 2
  else
    return base * (exponentiate_2(base, (exp -1) / 2) ** 2)
  end
end

class Array

  def deep_dup
    return self.dup if self.none? { |el| el.is_a?(Array) }
    self.map do |el|
      el.is_a?(Array) ? el.deep_dup : el
    end
  end

end

def fibo(n)
  return [1] if n == 1
  return [1,1] if n == 2
  numbers = fibo(n - 1)
  numbers.concat([numbers[-2] + numbers[-1]])
end

def subsets(arr)
  return [[]] if arr.size == 0
  return [[], arr] if arr.size == 1
  results = [arr.dup]
  arr.dup.each_index do |i|
    arr_ind = arr.dup
    arr_ind.delete_at(i)
    results.concat(subsets(arr_ind))
  end
  results.uniq
end

def subsets_up(arr)
  return [[]] if arr.size == 0
  # return [[], arr] if arr.size == 1
  next_num = arr.first
  copy = arr.dup
  copy.each_index do |i|
    copy[i] << next_num
    subsets_up((copy *= 2) << [])
  end
  return copy
end

def permutations(arr)
  return [arr] if arr.size == 1
  this_arr = arr.dup
  results = []
  this_arr.each_index do |i|
    copy_arr = arr.dup
    copy_arr.delete_at(i)
    p permutations(copy_arr)
    results += permutations(copy_arr).map { |el| [arr[i]] + el }
  end
  results
end

def bsearch(array, target)
  if array.size == 1 && target != array.first
    return "not found"
  end
  middle_i = array.length.even? ? array.length/2 : (array.length - 1)/2
  offset = middle_i + 1
  if target == array[middle_i]
    return middle_i
  elsif target < array[middle_i]
    result = bsearch(array[0...middle_i], target)
    return "not found" if result.is_a?(String)
    result
  else
    result = bsearch(array[middle_i + 1..-1], target)
    return "not found" if result.is_a?(String)
    result + offset
  end
end

def merge (first_half, second_half)
  return first_half if second_half.empty?
  return second_half if first_half.empty?
  result = []
  while !first_half.empty? && !second_half.empty?
    if first_half.first > second_half.first
      result << second_half.shift
    else
      result << first_half.shift
    end
  end
  first_half.empty? ? result += second_half : result += first_half
  result
end

def merge_sort(array)
  return array if array.size == 1
  merge(merge_sort(array.take(array.size / 2)),
                    merge_sort(array.drop(array.size / 2)))
end

def greedy_make_change(change, coins=[25,10,5,1])
  if change == 0
    return []
  elsif coins.include?(change)
    return [change]
  else
    results = []
    coins.sort
    p coins
    possible_coins = coins.select { |coin| coin <= change }
    p possible_coins
    coin = possible_coins.max
    p coin
    (change / coin).times { results << coin }
    results += greedy_make_change(change % coin, coins)
  end
end

def make_better_change(change, coins=[25,10,5,1])
  if change == 0
    return []
  elsif coins.include?(change)
    return [change]
  else
    solutions = []
    possible_coins = coins.select { |coin| coin <= change }
    possible_coins.each do |coin|
      p coin
      results = [coin]
      results += make_better_change(change - coin, possible_coins)
      solutions << results
    end
    solutions.min_by { |el| el.size }
  end
end

# def perms_2(arr)
#   return [arr] if arr.size == 1
#   [[[arr[0]] + perms_2(arr[1..-1])], [perms_2(arr[1..-1]) + [arr[0]]]]
# end
# coins.sort
# possible_coins = coins.select { |coin| coin <= change }
# coin = possible_coins.max
# (change / coin).times { results << coin }
# results += greedy_make_change(change % coin, coins)
# solutions << results
# solutions
