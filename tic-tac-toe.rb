class Game
  def initialize
    #array of values
    @grid = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "]
    ]

    #initialize players
    puts "Insert name for player \"X\": "
    p1 = gets.chomp.to_s
    @player1 = Player.new(p1, "X")
    puts "Insert name for player \"O\": "
    p2 = gets.chomp.to_s
    @player2 = Player.new(p2, "O")

    #starting from player2, because had to start a round from 
    #player switch to diplay winner correctly
    @current_player = @player2
    play_game
  end

  private

  def play_game
    print_grid
    until has_won? || grid_full?
      play_round
    end
    if has_won?
      puts "\nAnd the winner is:\nPlayer \"#{@current_player.sign}\": called: #{@current_player.name}!"
    else
      puts "\nThis is a draw."
    end
  end

  #Exception handler to make sure the inputs are correct
  def input_check
    begin
      num = Kernel.gets.match(/^[1-3]$/)[0]
    rescue
      puts "Erroneous input! Try again..."
      retry
    else  
      num.to_i - 1
    end
  end

  def print_grid
    puts "\n\t      Column"
    puts "\t     1   2   3 "
    puts "\t   1 #{@grid[0][0]} | #{@grid[0][1]} | #{@grid[0][2]}"
    puts "\tR   ---|---|---\n"
    puts "\to  2 #{@grid[1][0]} | #{@grid[1][1]} | #{@grid[1][2]}"
    puts "\tw   ---|---|---\n"
    puts "\t   3 #{@grid[2][0]} | #{@grid[2][1]} | #{@grid[2][2]}\n"
  end

  def put_mark
    puts "\nPlayer \"#{@current_player.sign}\": #{@current_player.name}"
    puts "Which column?"
    column = input_check
    puts "Which row?"
    row = input_check

    #check if field is empty
    if @grid[row][column].match(/[\s]/) #match default/empty grid value
      @grid[row][column] = @current_player.sign
      print_grid
    else
      puts "\n\n\nAlas, that field is already taken. Try again:"
      print_grid
      put_mark
    end
  end

  def switch_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def play_round
    switch_player
    put_mark
  end

  def has_won?
    #loop to check win conditions.
    #Left accross conditions stay in loop for ease of coding,
    #despite unnecessary checks
    3.times do |i|
      if (
        @grid[i][0] == @current_player.sign &&
        @grid[i][1] == @current_player.sign &&
        @grid[i][2] == @current_player.sign
        )
        return true
      elsif (
        @grid[0][i] == @current_player.sign &&
        @grid[1][i] == @current_player.sign &&
        @grid[2][i] == @current_player.sign
        )
        return true
      elsif (
        @grid[0][0] == @current_player.sign &&
        @grid[1][1] == @current_player.sign &&
        @grid[2][2] == @current_player.sign
        )
        return true
      elsif (
        @grid[0][2] == @current_player.sign &&
        @grid[1][1] == @current_player.sign &&
        @grid[2][0] == @current_player.sign
        )
        return true
      end
    end
    false
  end

  def grid_full?
    if (
      @grid[0].include?(" ") ||
      @grid[1].include?(" ") ||
      @grid[2].include?(" ")
    )
      return false
    else
      return true
    end
  end
end

class Player# < Game
  attr_reader :name, :sign
  def initialize(name, sign)
    @name = name
    @sign = sign
  end
end
game = Game.new
