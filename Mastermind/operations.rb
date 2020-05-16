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
