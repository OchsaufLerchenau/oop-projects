load 'operations.rb'
load 'computer-ai.rb'
load 'player.rb'
load 'game.rb'

player = Player.new("Player")
computer = Player.new("Computer")
game = Game.new(player, computer)
game.create_pattern_peg_set(computer)
game.create_board
game.iterate_colors
