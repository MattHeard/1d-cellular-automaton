#!/usr/bin/env ruby

require 'optparse'

class Automaton
  PICTURE = [" ", "█"]
  ROW_WIDTH = `/usr/bin/env tput cols`.to_i
  ROWS = `/usr/bin/env tput lines`.to_i
  UNKNOWN_VALUE_PICTURE = "?"

  def initialize(rule)
    @rule = rule
  end

  def display_grid(grid)
    puts grid.map { |cell| picture(cell) }.join
  end

  def next_step(grid)
    neighbourhoods = chunk_into_neighbourhoods(grid)
    codes = neighbourhoods.map { |matrix| neighbourhood_code(matrix) }
    codes.map { |code| apply_rule(@rule, code) }
  end

  def initial_grid
    grid = Array.new(ROW_WIDTH, 0)
    grid[ROW_WIDTH / 2] = 1
    grid
  end

  def fill_screen(grid)
    (ROWS - 2).times do |_|
      grid = next_step(grid)
      display_grid(grid)
    end
  end

  private

  def chunk_into_neighbourhoods(grid)
    size = grid.size
    size.times.map do |index|
      [ grid[(index - 1) % size], grid[index], grid[(index + 1) % size] ]
    end
  end

  # Assumes 1*n neighbourhood matrix
  # TODO Investigate using the Matrix class
  def neighbourhood_code(neighbourhood)
    size = neighbourhood.size
    powers = size.times.map { |i| 2 ** i }.reverse
    size.times
      .map { |i| neighbourhood[i] * powers[i] }
      .inject(0) { |sum, n| sum + n }
  end

  # TODO Replace with math-based transformation rather than string-based
  def neighbourhood_matrix(code)
    size = 3
    binary_array(code, size)
  end

  def binary_array(number, length)
    format_string = "%#{length}s"
    (format_string % number.to_s(2)).gsub(/ /, "0").chars.map(&:to_i)
  end

  # TODO Apply any rule
  def apply_rule(rule, neighbourhood_code)
    size = 8
    rule_array = binary_array(rule, size).reverse
    rule_array[neighbourhood_code]
  end

  def picture(cell)
    PICTURE[cell] || UNKNOWN_VALUE_PICTURE
  end
end

if __FILE__ == $PROGRAM_NAME
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: automaton.rb [options]"
    opts.on("-wRULE", "--wolfram=RULE", "Wolfram rule to apply") do |r|
      options[:rule] = r
    end
  end.parse!

  rule = options[:rule].to_i
  p rule
  automaton = Automaton.new(rule)
  grid = automaton.initial_grid
  automaton.display_grid(grid)
  automaton.fill_screen(grid)
end
