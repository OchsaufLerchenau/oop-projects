class Game
  include Operations

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def create_board
    @board = []
    12.times do |i|
      @board.push(["      ", "      ", "      ", "      "])
    end
  end

  def format_color_name(color_name)
    if color_name.length < 6
      (6 - color_name.length).times do |i|
        if i.even?
          color_name += " "
        else
          color_name = " " + color_name
        end
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
      print_peg_set(peg_set)
    end
  end
end
