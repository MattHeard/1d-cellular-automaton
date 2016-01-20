class Automaton
  PICTURE = [' ', '█']

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
    PICTURE[cell]
  end
end

if __FILE__ == $PROGRAM_NAME
  grid = [ 1, 0, 0, 1, 0, 1, 0, 0, 1 ]
  Automaton.new.display_grid(grid)
  p Automaton.new.neighbourhoods(grid)
end
