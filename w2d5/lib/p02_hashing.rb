class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 1984 if self.empty?
    result = 0
    self.each_with_index do |el, idx|
      result += idx * el.to_i.hash unless el.is_a?(Array)
      result += idx * el.hash if el.is_a?(Array)
      result %= 1_037
    end
    result
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    temp_array = self.keys + self.values
    new_array = []
    temp_array.each do |el|
      if el.is_a?(Symbol)
        new_array << el.to_s.hash
      elsif el.is_a?(TrueClass)
        new_array << 137
      elsif el.is_a?(FalseClass)
        new_array << 230
      elsif el.is_a?(String)
        new_array << el.to_s.hash
      else
        new_array << el
      end
    end

    result = (new_array.sort!).hash
    return result
  end
end
