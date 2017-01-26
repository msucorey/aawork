require 'set'

class WordChainer

  attr_reader :dictionary

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map { |el| el.chomp })
  end

  def adjacent_words(word)
    result = []
    alphabet = ('a'..'z').to_a

    word.chars.each_index do |pos|
      alphabet.each do |letter|
        candidate_word = word.dup
        candidate_word[pos] = letter
        if @dictionary.include?(candidate_word)
          result << candidate_word unless candidate_word == word
        end
      end
    end

    result
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    until @current_words.empty?
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
    build_path_target(target)
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        next if @all_seen_words.has_key?(adj_word)
        new_current_words << adj_word
        @all_seen_words[adj_word] = current_word
      end
    end
    new_current_words.each do |word|
      puts "#{word} => #{@all_seen_words[word]}"
    end
    new_current_words
  end

  def build_path_target(target)
    path = []
    path << build_path_target(@all_seen_words[target])
    path
  end











  def old_adjacent_words(word)
    result = []
    @dictionary.each do |entry|
      next if entry.length != word.length
      num_diff = 0
      entry.chars.each_with_index do |char, i|
        num_diff +=1 if char != word[i]
      end
      result << entry if num_diff == 1
    end
    result
  end

  # def run(source, target)
  #   @current_words = [source]
  #   @all_seen_words = [source]
  #   until @current_words.empty?
  #     new_current_words = []
  #     @current_words.each do |current_word|
  #       adjacent_words(current_word).each do |adj_word|
  #         next if @all_seen_words.include?(adj_word)
  #         new_current_words << adj_word
  #         @all_seen_words << adj_word
  #       end
  #     end
  #     p new_current_words
  #     @current_words = new_current_words
  #   end
  # end

end
