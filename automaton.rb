class Automaton
  def build_initial_configuration
    number_of_columns =  `/usr/bin/env tput cols`.to_i
    grid = Array.new(number_of_columns, " ")
    middle = number_of_columns / 2
    grid[middle] = "█"
    puts grid.join
  end
end

if __FILE__ == $PROGRAM_NAME
  Automaton.new.build_initial_configuration
end
