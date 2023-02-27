# frozen_string_literal: true

class Player
  attr_reader :name, :character
  attr_accessor :score

  def initialize(order, player1_name = nil, player1_character = nil, name = nil, character = nil, score = 0)
    @order = order
    @player1_name = player1_name
    @player1_char = player1_character
    @name = name
    @character = character
    @score = score
    create_player(@order)
  end

  def create_player(order)
    case order
    when 'first'
      @name = ask_name('first')
      loop do
        @character = ask_char('first')
        break if @character.length == 1 && @character.match(/[a-zA-Z]/)
      end
    when 'second'
      loop do
        @name = ask_name('second')
        break unless @name == @player1_name
      end

      loop do
        @character = ask_char('second')
        break if @character != @player1_char && @character.match(/[a-zA-Z]/) && @character.length == 1
      end
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
      puts "\n#{@name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"
    when 'second'
      puts "\n#{@name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"
      puts "It can't be '\e[1m#{@player1_char}\e[0m'!\n\n"
    end
    gets.chomp
  end
end
