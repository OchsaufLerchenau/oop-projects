class Game
  include Operations

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def create_board
    @board = []
    12.times do |i|
      @board.push([["      ", "      ", "      ", "      "], []])
    end
  end

  def create_pattern_peg_set(player)
    if player.name == "Computer"
      @peg_set = random_peg_array
    else
      @peg_set = peg_input
    end
  end

  def format_color_name(color_name)
    (8 - color_name.length).times do |i|
      if i.even?
        color_name += " "
      else
        color_name = " " + color_name
      end
    end
    color_name
  end

  def print_peg_set(four_item_array)
    new_peg_array = []
    four_item_array.each do |color_name|
      new_peg_array.push(format_color_name(color_name))
    end
    print new_peg_array[0]
    3.times do |i|
      print "|" + new_peg_array[i + 1]
    end
    puts
  end

  def print_board
    @board.each do |peg_set|
      if peg_set[1] == []
        print_peg_set(peg_set[0])
      else
        print_peg_set(peg_set[0]) + "    || #{peg_set[1]}"
      end
    end
  end
end
