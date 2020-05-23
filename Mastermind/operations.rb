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

  def peg_check(pattern, to_check)
    arr = []
    pattern_counts = Hash.new(0)
    to_check_counts = Hash.new(0)

    pattern.each { |color| pattern_counts[color] += 1 }
    to_check.each { |color| to_check_counts[color] += 1 }

    arr = white_peg_check(pattern_counts, to_check_counts, arr)
    arr = black_peg_check(pattern, to_check, arr)
    arr.shuffle
  end

  def create_all_possibilities
    possible_peg_sets = []
    6.times do |a|
      6.times do |b|
        6.times do |c|
          6. times do |d|  
            temp_arr = []
            temp_arr.push(
              POSS_COLORS[a],
              POSS_COLORS[b],
              POSS_COLORS[c],
              POSS_COLORS[d]
              )
            possible_peg_sets.push(temp_arr)
          end
        end
      end
    end
    possible_peg_sets
  end
end
