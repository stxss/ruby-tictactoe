# Creating the Game Class, which stores the player's names, selected character and score
class Game
  # Names and selected characters only need to be read, while the game/score may need to be changed
  attr_reader :player1_name, :player2_name, :player1_char, :player2_char, :player1_score, :player2_score
  attr_accessor :game

  # Upon initialization, asking for the players names and playing characters
  def initialize
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

    # Create both players 'profiles'
    @player1 = Player.new(player1_name, player1_char, player1_score)
    @player2 = Player.new(player2_name, player2_char, player2_score)

    # After having the necesseary information for both players, starting a new board
    # @game = Board.new(player1_char, player2_char)
    @game = Board.new(@player1, @player2)
  end

  # Method for asking the name
  def ask_name(order)
    case order
    when 'first'
      puts "Please, enter the name of the first player: \n"
    when 'second'
      puts "\nPlease, enter the name of the second player: \n"
    end
    gets.chomp
  end

  # Method for asking the playing character
  def ask_char(order)
    case order
    when 'first'
      puts "\n#{player1_name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"
    when 'second'
      puts "\n#{player2_name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"
      puts "It can't be #{player1_char}!\n\n"
    end
    gets.chomp
  end
end

# Creating the class to store the players info
class Player
  attr_reader :name, :character
  attr_accessor :score

  def initialize(name, character, score)
    @name = name
    @character = character
    @score = score
  end
end

# Creating the class for the Tic-Tac-Toe board
class Board
  attr_accessor :board, :is_winner, :turn
  attr_reader :marker, :player1, :player2

  def initialize(player1, player2)
    # Setting a flag to know if a winner was found
    @is_winner = false

    @player1 = player1
    @player2 = player2

    # Creating the array for the rows and columns of the board
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    # Playing a round, passing the players' characters and whose turn is it to play
    @turn = 1
    until @is_winner
      round(player1.character, player2.character, turn)
      @turn += 1

      @is_winner = true if turn == 10
    end
  end

  def round(player1, player2, turn)
    # Cheching whose turn is it to play
    play = turn.odd? ? 'first' : 'second'

    # Asking the player for the play position from the available squares
    placing = player_play.to_i - 1

    # Interpreting the answer to the row and column values
    row = placing / 3
    column = placing % 3

    # Placing the players' character into their desired position
    @marker = if play == 'first'
                @player1.character
              else
                @player2.character
              end

    board[row][column] = marker

    # Printing out the board
    print_board
    win_check(@player1, @player2)
  end

  # Function to get the player's play
  def player_play
    puts "\nPlease, select the position you want to play in: \n"
    gets.chomp
  end

  # Function to print out the board, updating it as well on each round
  def print_board
    system('clear')
    puts "     #{board[0][0]} | #{board[0][1]} | #{board[0][2]}\n"
    puts '    ---+---+---'
    puts "     #{board[1][0]} | #{board[1][1]} | #{board[1][2]} \n"
    puts '    ---+---+---'
    puts "     #{board[2][0]} | #{board[2][1]} | #{board[2][2]} \n"
  end

  def win_check(player1, player2)
    return unless row_win? || col_win? || diag_win?

    winner = if marker == player1.character
               player1.name
             else
               player2.name
             end

    puts "There's a winner! The winner is #{winner}"
    @is_winner = true
  end

  def row_win?
    (0..2).any? do |row|
      board[row].all?(marker)
    end
  end

  def col_win?
    (0..2).any? do |col|
      board.transpose[col].all?(marker)
    end
  end

  def diag_win?
    # Top left to bottom right diagonal
    tlbr_diag = []
    bltr_diag = []

    # Inserting the first and second diagonals into arrays
    3.times do |i|
      tlbr_diag.push(board[i][i])
      bltr_diag.push(board.reverse[i][i])
    end

    tlbr_diag.all?(marker) || bltr_diag.all?(marker)
  end
end

# Starting the game
Game.new
# start = Game.new
# p start.game.round

# TODO: players' can't put their marker on top of somebody elses (no overwriting)
# TODO: when someone wins, updating the score
# TODO: after a finished round, ask if they want to continue with the game
# TODO:
# Idea: create a hash to store the player's name and their character, as a key value pair, for easier checking of who won
