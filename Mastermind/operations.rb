module Operations
  POSS_COLORS = ["red", "orange", "yellow", "green", "blue", "purple"]

  def random_peg_array
    arr = []
    4.times do |color|
      arr.push(POSS_COLORS[rand(6)])
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
    elsif input == "reset".downcase
      input.downcase
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
      if input == "reset"
        peg_input
      else
        peg_choice.push(POSS_COLORS[input.to_i])
      end
    end
    peg_choice
  end

  def white_peg_check(pattern_counts, to_check_counts, arr)
    to_check_counts.each_key do |color|
      if pattern_counts[color]
        if pattern_counts[color] >= to_check_counts[color]
          to_check_counts[color].times { arr.push("white") }
        elsif pattern_counts[color] < to_check_counts[color]
          pattern_counts[color].times { arr.push("white") }
        end
      end
    end
    arr
  end

  def black_peg_check(pattern, to_check, arr)
    4.times do |i|
      if pattern[i] == to_check[i]
        arr.pop
        arr.unshift("black")
      end
    end
    arr
  end
end
