class Game
  attr_reader :player1, :player2
  attr_accessor :game

  def initialize(p1 = "new", p2 = "new")
    @p1 = p1
    @p2 = p2
    @player1 = nil
    @player2 = nil
    @game = nil
  end

  def play
    if @p1 == "new" && @p2 == "new"
      player_setup
    end
    board_setup(@p1, @p2)
  end

  private

  def player_setup
    @player1 = Player.new
    @player1.create_player("first")

    @player2 = Player.new(@player1.name, @player1.character)
    @player2.create_player("second")
  end

  def board_setup(p1, p2)
    @game = board = if p1 == "new" || p2 == "new"
              Board.new(@player1, @player2)
            else
              Board.new(p1, p2)
            end
    board.game
  end
end
