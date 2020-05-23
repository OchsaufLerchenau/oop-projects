class AI
  include Operations

  def initialize
    @possible_peg_sets = []
  end

  def comp_play
    peg_
  end

  def create_all_possibilities
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
            @possible_peg_sets.push(temp_arr)
          end
        end
      end
    end
  end
end