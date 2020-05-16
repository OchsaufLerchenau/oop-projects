module Operations
  POSS_COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]

  def random_peg_array
    arr = []
    4.times do |color|
      arr.push(POSS_COLORS[rand(6)])
    end
    arr
  end

  def peg_check(pattern, to_check)
    arr = []
    4.times do |i|
      if pattern[i] == to_check[i]
        arr.push("black")
      elsif pattern[i] != to_check[i] && pattern.include?(to_check[i])
        arr.push("white")
      end
    end
    arr
  end

  def display_poss_pegs
    POSS_COLORS.each_with_index do |color, idx|
      print "#{idx + 1}: " + color + "    "
    end
    puts
  end

  def input_check
    input = gets.chomp
    if input.match(/^[1-6]$/)
      input.to_i - 1
    elsif POSS_COLORS.include?(input.downcase)
      POSS_COLORS.index(input.downcase)
    elsif input == "reset"
      input
    else
      puts "Wrong input. Try again!"
      input_check
    end
  end

  def peg_input
    display_poss_pegs
    peg_choice = []
    puts "\nPut in your peg choices 1-4."
    puts "You can write color numbers or names, type reset to restart."
    4.times do |i|
      input = input_check
      if input == "reset".downcase
        peg_input
      else
        peg_choice.push(POSS_COLORS[input.to_i])
      end
    end
    p peg_choice
  end
end

class Player
  include Operations
  attr_reader :name

  def initialize(name, peg_set = [])
    @name = name
    @peg_set = peg_set
  end
end

class Game
  include Operations

  def initialize(player, computer)
    @player = Player.
    @computer = computer
  end

  def create_board
    @board = []
    12.times do |i|
      @board.push(["      ", "      ", "      ", "      "])
    end
    display_poss_pegs
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

puts "Input your name:"
player = Player.new(gets.chomp)
computer = Player.new("Computer", random_peg_array)
game = Game.new(player, computer)
game.create_board
puts computer.name
