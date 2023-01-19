# Creating the Game Class, which stores the player's names, selected character and score
class Game
  # Names and selected characters only need to be read, while the game/score may need to be changed
  attr_reader :player1_name, :player2_name, :player1_char, :player2_char
  attr_accessor :game

  # Upon initialization, asking for the players names and playing characters
  def initialize
    @player1_name = ask_name('first')
    @player1_char = ask_char('first')
    @player1 = Player.new(player1_name, player1_char, 0)

    @player2_name = ask_name('second')
    @player2_char = ask_char('second')
    @player2 = Player.new(player2_name, player2_char, 0)

    # After having the necesseary information for both players, starting a new board
    @game = Board.new(player1_char, player2_char)
  end

  # Method for asking the name
  def ask_name(order)
    case order
    when 'first'
      puts "Please, enter the name of the first player: \n\n"
    when 'second'
      puts "\nPlease, enter the name of the second player: \n\n"
    end
    gets.chomp
  end

  # Method for asking the playing character
  def ask_char(order)
    case order
    when 'first'
      puts "\n#{@player1_name}, please enter a character you want to play with, from 'a-z'\n\n"
    when 'second'
      puts "\n#{@player2_name}, please enter a character you want to play with, from 'a-z'\n\n"
    end
    gets.chomp
  end
end

# Creating the class to store the players info
class Player
  def initialize(name, character, score)
    @name = name
    @character = character
    @score = score
  end
end

# Creating the class for the Tic-Tac-Toe board
class Board
  attr_accessor :board, :is_winner, :turn
  attr_reader :marker

  def initialize(player1_char, player2_char)
    # Setting a flag to know if a winner was found
    is_winner = false

    # Creating the array for the rows and columns of the board
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    # Playing a round, passing the players' characters and whose turn is it to play
    @turn = 1
    until is_winner
      round(player1_char, player2_char, turn)
      @turn += 1

      is_winner = true if turn == 10
    end
  end

  def round(player1_char, player2_char, turn)
    # Cheching whose turn is it to play
    play = turn.odd? ? 'first' : 'second'

    # Asking the player for the play position from the available squares
    placing = player_play.to_i - 1

    # Interpreting the answer to the row and column values
    row = placing / 3
    column = placing % 3

    # Placing the players' character into their desired position
    @marker = if play == 'first'
                player1_char
              else
                player2_char
              end

    board[row][column] = marker

    # Printing out the board
    print_board
    puts "There's a winner!" if win_check
  end

  # Function to get the player's play
  def player_play
    puts "Please, select the position you want to play in: \n"
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

  def win_check
    row_win?
    col_win?
    diag_win?
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
