require 'pry'
class Game
  include Operations

  def initialize(player, computer)
    @player = player
    @computer = computer
    @peg_pattern = []
    @round_count = 0
    @has_won = false
  end

  def create_board
    @board = []
    12.times do |i|
      @board.push([["      ", "      ", "      ", "      "], []])
    end
  end

  def create_pattern_peg_set(player)
    if player.name == "Computer"
      @peg_pattern = random_peg_array
      # p @peg_pattern
    else
      @peg_pattern = peg_input
    end
  end

  def play_game
    until @has_won do
      play_round
    end
    if @has_won
      puts "\nCongratulations, you beat the machine!\n\n"
    else
      puts "\nComiserations, you lost :(\n\n"
    end
  end

  # private
  
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

  def format_peg_set(four_item_array)
    new_peg_array = []
    formatted_set = ""
    four_item_array.each do |color_name|
      new_peg_array.push(format_color_name(color_name))
    end
    formatted_set += new_peg_array[0]
    3.times do |i|
      formatted_set += "|" + new_peg_array[i + 1] 
    end
    formatted_set
  end

  def peg_check(pattern, to_check)
    arr = []
    pattern_counts = Hash.new(0)
    to_check_counts = Hash.new(0)

    pattern.each { |color| pattern_counts[color] += 1 }
    to_check.each { |color| to_check_counts[color] += 1 }

    arr = white_peg_check(pattern_counts, to_check_counts, arr)
    arr = black_peg_check(pattern, to_check, arr)

    if arr == ["black", "black", "black", "black"]
      @has_won = true
    end
    arr.shuffle
  end

  def print_board
    puts @board[0][1]
    @board.each do |peg_set|
      if peg_set[1] == []
        puts format_peg_set(peg_set[0])
      else
        puts format_peg_set(peg_set[0]) + "    || #{peg_set[1].flatten}"
      end
    end
  end

  def play_round
    @round_count += 1
    puts "Make a guess: #{@peg_pattern}"
    input = peg_input
    puts @board[@round_count - 1][0] = input
    puts @board[@round_count - 1][1] = peg_check(@peg_pattern, input)
    print_board
  end

end
