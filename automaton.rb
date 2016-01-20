class Automaton
  PICTURE = [' ', '█']

  def display_grid(grid)
    puts grid.map { |cell| picture(cell) }.join
  end

  private

  def picture(cell)
    PICTURE[cell]
  end
end

if __FILE__ == $PROGRAM_NAME
  grid = [ 1, 0, 0, 1, 0, 1, 0, 0, 1 ]
  Automaton.new.display_grid(grid)
end
