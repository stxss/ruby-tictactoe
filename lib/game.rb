class Game
  attr_reader :player1_name, :player2_name, :player1_char, :player2_char, :player1_score, :player2_score
  attr_accessor :game

  def initialize(p1, p2)
    if p1 == 'new' || p2 == 'new'
      @player1_name = ask_name('first')

      loop do
        @player1_char = ask_char('first')
        break if player1_char.length == 1 && player1_char.match(/[a-zA-Z]/)
      end

      loop do
        @player2_name = ask_name('second')
        break unless player2_name == player1_name
      end

      loop do
        @player2_char = ask_char('second')
        break if player2_char != player1_char && player2_char.match(/[a-zA-Z]/) && player2_char.length == 1
      end

      @player1_score = 0
      @player2_score = 0

      @player1 = Player.new(player1_name, player1_char, player1_score)
      @player2 = Player.new(player2_name, player2_char, player2_score)

      @game = Board.new(@player1, @player2)
    else
      @game = Board.new(p1, p2)
    end
  end

  def ask_name(order)
    case order
    when 'first'
      puts "\nPlease, enter the name of the first player: \n"
    when 'second'
      puts "\nPlease, enter the name of the second player: \n"
    end
    gets.chomp
  end

  def ask_char(order)
    case order
    when 'first'
      puts "\n#{player1_name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"
    when 'second'
      puts "\n#{player2_name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"
      puts "It can't be '\e[1m#{player1_char}\e[0m'!\n\n"
    end
    gets.chomp
  end
end
