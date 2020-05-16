class Player
  include Operations
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def create_pattern_peg_set
    if @name == "Computer"
      @peg_set = random_peg_array
    else
      @peg_set = peg_input
    end
  end
end
