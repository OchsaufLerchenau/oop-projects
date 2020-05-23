load 'operations.rb'
load 'computer-ai.rb'
load 'player.rb'
load 'game.rb'

player = Player.new("Player")
computer = Player.new("Computer")
game = Game.new(player, computer)
game.create_board
game.play_game