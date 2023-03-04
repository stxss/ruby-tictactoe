class Player
  attr_reader :name, :character, :order
  attr_accessor :score

  def initialize(player1_name = nil, player1_character = nil, name = nil, character = nil, score = 0)
    @player1_name = player1_name
    @player1_char = player1_character
    @name = name
    @character = character
    @score = score
  end

  def create_player(order)
    @order = order
    @name = ask_name(order)
    @character = ask_char(order)
  end

  def ask_name(order)
    puts "\nPlease, enter the name of the #{order} player: \n"
    loop do
      user_input = gets.chomp
      verified_name = verify_name(order, user_input)
      return verified_name if verified_name

      puts "You can't use another player's name!"
    end
  end

  def ask_char(order)
    puts "\n#{@name}, please enter a character you want to play with, from 'a-Z'. Use only 1 character.\n"

    case order
    when "second"
      puts "It can't be '\e[1m#{@player1_character}\e[0m'!\n\n"
    end

    loop do
      user_input = gets.chomp
      verified_char = verify_char(order, user_input)
      return verified_char if verified_char

      puts "Use a valid character please!"
    end
  end

  def verify_name(order, input)
    case order
    when "first"
      input
    when "second"
      input if input != @player1_name
    end
  end

  def verify_char(order, input)
    case order
    when "first"
      input if input.length == 1 && input.match(/[a-zA-Z]/)
    when "second"
      input if input.length == 1 && input.match(/[a-zA-Z]/) && input != @player1_character
    end
  end
end
