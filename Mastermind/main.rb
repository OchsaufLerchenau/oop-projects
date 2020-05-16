load 'operations.rb'
load 'player.rb'
load 'game.rb'

puts "Input your name:"
player = Player.new(gets.chomp)
computer = Player.new("Computer")
computer.create_pattern_peg_set
game = Game.new(player, computer)
game.create_board
game.print_peg_set(computer.peg_set)
