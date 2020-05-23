class AI
  include Operations

  def initialize
    @possible_peg_sets = []
  end

  def comp_play
  end

  def iterate_colors
    p POSS_COLORS.each { |color| color }
  end

  def create_all_possibilities
    POSS_COLORS.each do |color|
    end
  end
end