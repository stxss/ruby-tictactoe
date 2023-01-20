# frozen_string_literal: true

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

# Creating the Game Class, which stores the player's names, selected character and score
class Game
  # Names and selected characters only need to be read, while the game/score may need to be changed
  attr_reader :player1_name, :player2_name, :player1_char, :player2_char, :player1_score, :player2_score
  attr_accessor :game

  # Upon initialization, asking for the players names and playing characters
  def initialize(p1, p2)
    # If the players are new, aka if it's a completely new game, create new profiles
    if p1 == 'new' || p2 == 'new'
      @player1_name = ask_name('first')

      # Loop asking for the player's character until it satisfies the conditions of having the length of 1 and being a letter, case doesn't matter
      loop do
        @player1_char = ask_char('first')
        break if player1_char.length == 1 && player1_char.match(/[a-zA-Z]/)
      end

      # Loop asking the name of the second player if it is equal to the name of the first
      loop do
        @player2_name = ask_name('second')
        break unless player2_name == player1_name
      end

      loop do
        @player2_char = ask_char('second')
        break if player2_char != player1_char && player2_char.match(/[a-zA-Z]/) && player2_char.length == 1
      end

      # Setting base score to 0
      @player1_score = 0
      @player2_score = 0

      # Create both players 'profiles'
      @player1 = Player.new(player1_name, player1_char, player1_score)
      @player2 = Player.new(player2_name, player2_char, player2_score)

      # After having the necesseary information for both players, starting a new board
      @game = Board.new(@player1, @player2)
    else
      # If the players have already played some rounds, just create a new board, no need to 'register' new players
      @game = Board.new(p1, p2)
    end
  end

  # Method for asking the name
  def ask_name(order)
    case order
    when 'first'
      puts "\nPlease, enter the name of the first player: \n"
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
      puts "It can't be '\e[1m#{player1_char}\e[0m'!\n\n"
    end
    gets.chomp
  end
end

# Creating the class for the Tic-Tac-Toe board
class Board
  attr_accessor :board, :is_winner, :turn, :placing
  attr_reader :marker, :player1, :player2

  def initialize(player1, player2)
    # Setting a flag to know if a winner was found
    @is_winner = false

    @player1 = player1
    @player2 = player2

    # Creating the array for the rows and columns of the board
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    # Playing a round, passing the players' characters and whose turn is it to play, until there is a winner
    @turn = 1
    until @is_winner
      round(turn)

      # If all the squares are occupied and there's no winner, set a tie and prompt for a restart
      if turn == 10 && @is_winner == false
        puts "Okay, no more places are available and there is no winner, so it's a tie!\n"
        restart
      end
    end
  end

  def round(turn)
    # Cheching whose turn is it to play
    play = turn.odd? ? 'first' : 'second'

    # Asking the player for the play position from the available squares
    loop do
      puts "\nPlease, select the position you want to play in (1-9): \n"
      @placing = gets.chomp.to_i - 1
      break if @placing.between?(0, 9)
    end

    # Interpreting the answer to the row and column values
    @row = placing / 3
    @column = placing % 3

    # Placing the players' character into their desired position
    @marker = if play == 'first'
                @player1.character
              else
                @player2.character
              end

    # board[@row][@column] = marker
    unless (board[@row][@column] == @player1.character) || (board[@row][@column] == @player2.character)
      board[@row][@column] = marker
      @turn += 1
    end
    # Printing out the board
    print_board

    # Unless there is a winner, continue playing
    return unless win_check(@player1, @player2)

    # Prompt for the restart if there's a winner of the round
    restart
  end

  # Method for restart
  def restart
    loop do
      puts "\nDo you want to play again? Please enter a valid option. [Y/N]"
      answer = gets.chomp
      case answer
      when 'Y', 'y', 'yes'.downcase
        Game.new(@player1, @player2)
      when 'N', 'n', 'no'.downcase
        exit
      end
    end
  end

  # Function to print out the board, updating it on each played round
  def print_board
    system('clear')
    puts "           #{board[0][0]} | #{board[0][1]} | #{board[0][2]}      | \e[4mPlayer scores\e[0m\n"
    puts '          ---+---+---     |'
    puts "           #{board[1][0]} | #{board[1][1]} | #{board[1][2]}      | #{player1.character}: #{player1.score} => #{player1.name}\n"
    puts "          ---+---+---     | #{player2.character}: #{player2.score} => #{player2.name}"
    puts "           #{board[2][0]} | #{board[2][1]} | #{board[2][2]}      |\n"
  end

  # Method to check for a winner
  def win_check(player1, player2)
    # Unless there is a win, continue playing
    return unless row_win? || col_win? || diag_win?

    # Seeing what was the winning marker and assigning the winner accordingly
    winner = if marker == player1.character
               player1
             else
               player2
             end

    # Updating the winner's score, as well as the board, and flagging the is_winner to true, to prompt for a new round
    winner.score += 1
    puts "\nThere's a winner! The winner is #{winner.name} and their score is #{winner.score}\n"
    print_board
    @is_winner = true
  end

  # Method for a row win
  def row_win?
    (0..2).any? do |row|
      board[row].all?(marker)
    end
  end

  # Method for a column win
  def col_win?
    (0..2).any? do |col|
      board.transpose[col].all?(marker)
    end
  end

  # Method for a diagonal win
  def diag_win?
    # Top left to bottom right diagonal (tlbr) and bottom left to top right diagonal (bltr)
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
Game.new('new', 'new')
