load 'game.rb'

class Player < Game
  include Operations
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
