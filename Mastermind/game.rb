require 'pry'

class Game
  include Operations

  def initialize(player, computer)
    @player = player
    @computer = computer
    @peg_pattern = []
    @round_count = 0
    @has_won = false
    @computer_plays = false
    @possible_peg_sets = []
    @all_peg_sets = create_all_possibilities
    @all_scores = Hash.new { |h, k| h[k] = {} }

    @all_peg_sets.product(@all_peg_sets).each do |guess, answer|
      @all_scores[guess][answer] = peg_check(guess, answer)
    end
    # @hash = Hash.new(0)
    # @all_scores[["red","red","red","red"]].each_value do |val|
    #   @hash[val] += 1
    # end
    # p @hash
  end

  def minimax
    uphash = {}
    @possible_scores.each do |key, val|
      hash = Hash.new(0)
      val.each_value do |value|
        hash[value] += 1
      end
      uphash[key] = hash.values.max
    end
    uphash.key(uphash.values.min)
  end

  def play_game
    create_board
    maker_or_breaker
    until @has_won || @round_count == 12 do
      play_round
    end
    if @has_won
      puts "\nCongratulations, you beat the machine!\n\n"
    else
      puts "\nComiserations, you lost :(\n"
      if @computer_plays
        puts "You got beat!"
      else
        puts "The computers peg set was: #{@peg_pattern}\n\n"
      end
    end
  end

  # private

  def create_pattern_peg_set(player)
    if player.name == "Computer"
      @peg_pattern = random_peg_array
    else
      @peg_pattern = peg_input
    end
  end
  
  def create_board
    @board = []
    12.times do |i|
      @board.push([["      ", "      ", "      ", "      "], []])
    end
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
      if @round_count == 1
        input = ["red", "red", "orange", "orange"]
      else
        input = computer_play
      end
    end
    @board[@round_count - 1][0] = input
    @board[@round_count - 1][1] = peg_check(@peg_pattern, input)

    if @board[@round_count - 1][1] == ["black", "black", "black", "black"]
      @has_won = true
    end
    print_board
  end

  def maker_or_breaker
    puts "Do you want to be the breaker or maker?"
    choice = gets.chomp
    if choice.downcase == "breaker"
      create_pattern_peg_set(@computer)
    elsif choice.downcase == "maker"
      create_pattern_peg_set(@player)
      @computer_plays = true
    else
      puts "Wrong input, try again..."
      maker_or_breaker
    end
  end

  def reduce_sets
    diminished_peg_sets = []
    @all_peg_sets.each do |set|
      if (
        peg_check(@board[@round_count - 2][0], set) == 
        @board[@round_count - 2][1]
      )
      diminished_peg_sets.push(@board[@round_count - 2][0])
      end
    end
    @possible_peg_sets = diminished_peg_sets
    p @possible_peg_sets.length
  end

  def computer_play
    @possible_peg_sets = @all_peg_sets.dup
    @possible_scores = @all_scores.dup
    
  end
end
