# frozen_string_literal: true

class Board
  attr_accessor :board, :is_winner, :turn, :placing
  attr_reader :marker, :player1, :player2

  def initialize(player1, player2)
    @is_winner = false

    @player1 = player1
    @player2 = player2

    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

    @turn = 1
    until @is_winner
      round(turn)

      if turn == 10 && @is_winner == false
        puts "Okay, no more places are available and there is no winner, so it's a tie!\n"
        restart
      end
    end
  end

  def round(turn)
    play = turn.odd? ? 'first' : 'second'

    loop do
      puts "\nPlease, select the position you want to play in (1-9): \n"
      @placing = gets.chomp.to_i - 1
      break if @placing.between?(0, 9)
    end

    @row = placing / 3
    @column = placing % 3

    @marker = if play == 'first'
                @player1.character
              else
                @player2.character
              end

    unless (board[@row][@column] == @player1.character) || (board[@row][@column] == @player2.character)
      board[@row][@column] = marker
      @turn += 1
    end
    print_board

    return unless win_check(@player1, @player2)

    restart
  end

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

  def print_board
    if RUBY_PLATFORM =~ /win32/ || RUBY_PLATFORM =~ /mingw/
      system('cls')
    else
      system('clear')
    end
    puts "           #{board[0][0]} | #{board[0][1]} | #{board[0][2]}      | \e[4mPlayer scores\e[0m\n"
    puts '          ---+---+---     |'
    puts "           #{board[1][0]} | #{board[1][1]} | #{board[1][2]}      | #{player1.character}: #{player1.score} => #{player1.name}\n"
    puts "          ---+---+---     | #{player2.character}: #{player2.score} => #{player2.name}"
    puts "           #{board[2][0]} | #{board[2][1]} | #{board[2][2]}      |\n"
  end

  def win_check(player1, player2)
    return unless row_win? || col_win? || diag_win?

    winner = if marker == player1.character
               player1
             else
               player2
             end

    winner.score += 1
    puts "\nThere's a winner! The winner is #{winner.name} and their score is #{winner.score}\n"
    print_board
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
    tlbr_diag = []
    bltr_diag = []

    3.times do |i|
      tlbr_diag.push(board[i][i])
      bltr_diag.push(board.reverse[i][i])
    end

    tlbr_diag.all?(marker) || bltr_diag.all?(marker)
  end
end
