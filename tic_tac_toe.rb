class Game
  attr_reader :player1_name, :player2_name, :player1_char, :player2_char
  attr_accessor :game
  def initialize
    @player1_name = ask_name('first')
    @player1_char = ask_char('first')
    @player1 = Player.new(player1_name, player1_char, 0)

    @player2_name = ask_name('second')
    @player2_char = ask_char('second')
    @player2 = Player.new(player2_name, player2_char, 0)

    @game = Board.new()
  end

  def ask_name(order)
    if order == 'first'
      puts 'Please, enter the name of the first player: '
    elsif order == 'second'
      puts 'Please, enter the name of the second player: '
    end
    gets.chomp
  end

  def ask_char(order)
    if order == 'first'
      puts "#{@player1_name}, please enter a character you want to play with, from 'a-z'"
    elsif order == 'second'
      puts "#{@player2_name}, please enter a character you want to play with, from 'a-z'"
    end
    gets.chomp
  end
end

class Player
  def initialize(name, character, score)
    @name = name
    @character = character
    @score = score
    puts @name, @character, @score
  end
end

class Board
    def initialize()
        @is_winner = false

        board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "---+---+---"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "---+---+---"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def plays
        "you're playing!"
    end
end

start = Game.new
p start.game.plays
# puts start



