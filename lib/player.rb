class Player
  attr_reader :name, :character
  attr_accessor :score

  def initialize(name, character, score)
    @name = name
    @character = character
    @score = score
  end
end
