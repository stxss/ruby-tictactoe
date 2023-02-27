# frozen_string_literal: true

class Game
  attr_reader :player1, :player2
  attr_accessor :game

  def initialize(p1 = 'new', p2 = 'new')
    @p1 = p1
    @p2 = p2
    @player1 = nil
    @player2 = nil
    @game = nil
  end

  def play
    player_setup
    board_setup(@p1, @p2)
  end

  def player_setup
    @player1 = Player.new('first')
    @player2 = Player.new('second', @player1.name, @player1.character)
  end

  def board_setup(p1, p2)
    @game = if p1 == 'new' || p2 == 'new'
              Board.new(@player1, @player2)
            else
              Board.new(p1, p2)
            end
  end
end
