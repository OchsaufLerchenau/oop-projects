load 'operations.rb'
load 'player.rb'
load 'game.rb'

puts "Input your name:"
player = Player.new(gets.chomp)
computer = Player.new("Computer")
game = Game.new(player, computer)
game.create_pattern_peg_set(computer)
game.create_board
game.peg_check(game.random_peg_array, game.random_peg_array)
