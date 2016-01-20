class Automaton
  PICTURE = [" ", "█"]
  ROW_WIDTH = `/usr/bin/env tput cols`.to_i
  UNKNOWN_VALUE_PICTURE = "?"

  def display_grid(grid)
    puts grid.map { |cell| picture(cell) }.join
  end

  def neighbourhoods(grid)
    size = grid.size
    size.times.map do |index|
      [ grid[(index - 1) % size], grid[index], grid[(index + 1) % size] ]
    end
  end

  # Assumes 1*n neighbourhood matrix
  # TODO Investigate using the Matrix class
  def neighbourhood_id(neighbourhood)
    size = neighbourhood.size
    powers = size.times.map { |i| 2 ** i }.reverse
    size.times
      .map { |i| neighbourhood[i] * powers[i] }
      .inject(0) { |sum, n| sum + n }
  end

  private

  def picture(cell)
    PICTURE[cell] || UNKNOWN_VALUE_PICTURE
  end
end

if __FILE__ == $PROGRAM_NAME
  grid = [ 1, 0, 0, 1, 0, 1, 0, 0, 1 ]
  automaton = Automaton.new
  automaton.display_grid(grid)
  p automaton.neighbourhoods(grid)
  p automaton.neighbourhood_id([0, 0, 0])
  p automaton.neighbourhood_id([1, 1, 1])
  p automaton.neighbourhood_id([0, 1, 0])
end
