require 'pry'

class Game < AI
  include Operations

  def initialize(player, computer)
    @player = player
    @computer = computer
    @peg_pattern = []
    @round_count = 0
    @has_won = false
    @computer_plays = false
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
    else
      @peg_pattern = peg_input
    end
  end

  def play_game
    until @has_won || @round_count == 12 do
      play_round
    end
    if @has_won
      puts "\nCongratulations, you beat the machine!\n\n"
    else
      puts "\nComiserations, you lost :(\n"
      if @computer_plays
        puts "You got beat at difficulty level: \"#{@diff_level}\""
      else
        puts "The computers peg set was: #{@peg_pattern}\n\n"
      end
    end
  end

  private
  
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


  def print_board
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
    unless @computer_plays
      puts "Make a guess:"
      input = peg_input
    else
      input = comp_play
    end
    @board[@round_count - 1][0] = input
    @board[@round_count - 1][1] = peg_check(@peg_pattern, input)

    if @board[@round_count - 1][1] == ["black", "black", "black", "black"]
      @has_won = true
    end
    print_board
  end
end
