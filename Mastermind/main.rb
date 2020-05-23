load 'operations.rb'
load 'player.rb'
load 'game.rb'

player = Player.new("Player")
computer = Player.new("Computer")
game = Game.new(player, computer)
game.play_game