require_relative 'game'
require_relative 'tile'

class Board

  attr_reader :grid

  def self.from_file(file)
    grid = []
    File.readlines(file).each_with_index do |line, row_idx|
      this_row = []
      line.chomp.chars.each_with_index do |char, col_idx|
        this_row <<  Tile.new(char.to_i, [row_idx, col_idx])
      end
      grid << this_row
    end
    grid
  end

  def initialize(grid)
    @grid = grid
  end

  def render
    #A render method to display the current board state
    system("clear")
    result = []
    row_counter = 0
    puts "-------------"
    each_tile do |tile|
      result << tile.value
      if result.length == 9
        row_counter += 1
        string = result.join("")
        string = string.gsub("0", " ")
        puts "|#{string[0..2]}|#{string[3..5]}|#{string[6..8]}|"
        result = []
        if row_counter == 3
          puts "-------------"
          row_counter = 0
        end
      end
    end
  end

  def solved?
    each_tile do |tile|
      return false if tile.value.zero?
    end
    true
  end


  def cats_game?
    each_tile do |tile|
      value = tile.value
      position = tile.position
      return true unless valid_placement?(value, position)
    end
    false
  end

  def each_tile(&prc)
    @grid.each do |row|
      row.each do |tile|
        prc.call(tile)
      end
    end
  end

  def place_number(value, position)
    if valid_placement?(value, position)
      self[position] = value
    end

  end

  def valid_placement?(value, position)
    valid_row_placement?(value, position) &&
    valid_col_placement?(value, position) &&
    #valid_square_placement?(value, position)
  end

  def valid_row_placement?(value, position)
    return false unless empty?(position)
    row = @grid[position[0]]
    return false if row.any?{ |tile| tile.value == value }
    true
  end

  def valid_col_placement?(value, position)
    return false unless empty?(position)
    col = []
    @grid.each do |row|
      col << row[position[1]].value
    end
    return false if col.include?(value)
    true
  end

  # def valid_square_placement?(value, position)
  #   arr = []
  #
  # end

  def empty?(position)
    self[position].value == 0
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

end
