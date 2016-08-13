#-
# Assignment for Module #2: Calculate Maximum Word frequency
#-
class LineAnalyzer
  attr_reader  :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @line_number = line_number
    @content = content
    @highest_wf_count = 0
    calculate_word_frequency()
  end

  def calculate_word_frequency()
    word_frequency = Hash.new(0)
    words = @content.split
    words.each do |word|
        word_frequency[word.downcase] += 1
    end
    @highest_wf_count = word_frequency.values.max
    @highest_wf_words =[]
    word_frequency.each do |k, v|
      @highest_wf_words << k if v == word_frequency.values.max
    end
  end
end #class lineAnalyzer

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize()
    @analyzers = []
  end

  def analyze_file()
    line_number = 0
    File.foreach( 'test.txt' ) do |content|
      line_number += 1
      class_inst =LineAnalyzer.new content, line_number
      @analyzers << class_inst
    end
  end # analyze_file

  def calculate_line_with_highest_frequency()
  @highest_count_across_lines = 0
  @highest_count_words_across_lines = []
  maxi = 0
  @analyzers.each do |x|
      if x.highest_wf_count > maxi then maxi = x.highest_wf_count  end
  end
  @highest_count_across_lines = maxi

  @analyzers.each do |x|
      if x.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines << x
      end
  end
  # @highest_count_words_across_lines.each {|x| p x}

  end

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @analyzers.each do |x|
      if x.highest_wf_count == @highest_count_across_lines
        puts "#{x.highest_wf_words}  (appears in line #{x.line_number})"
      end
    end # do
  end # def
end # class Solution
