class Automaton
  PICTURE = [" ", "█"]
  ROW_WIDTH = `/usr/bin/env tput cols`.to_i

  def display_grid(grid)
    puts grid.map { |cell| picture(cell) }.join
  end

  def neighbourhoods(grid)
    size = grid.size
    size.times.map do |index|
      [ grid[(index - 1) % size], grid[index], grid[(index + 1) % size] ]
    end
  end

  private

  def picture(cell)
    PICTURE[cell] || "?"
  end
end

if __FILE__ == $PROGRAM_NAME
  grid = [ 1, 0, 0, 1, 0, 1, 0, 0, 1 ]
  automaton = Automaton.new
  automaton.display_grid(grid)
  p automaton.neighbourhoods(grid)
end
