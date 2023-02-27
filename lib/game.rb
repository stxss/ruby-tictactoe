# frozen_string_literal: true

class Game
  attr_reader :player1_name, :player2_name, :player1_char, :player2_char, :player1_score, :player2_score
  attr_accessor :game

  def initialize(p1 = 'new', p2 = 'new')
    if p1 == 'new' || p2 == 'new'

      @player1 = Player.new('first')
      @player2 = Player.new('second', @player1.name, @player1.character)

      @game = Board.new(@player1, @player2)
    else
      @game = Board.new(p1, p2)
    end
  end
end
