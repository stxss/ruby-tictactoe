class Game
    attr_reader :player1_name, :player2_name, :player1_char, :player2_char

    def initialize
        @player1_name = ask_name("first")
        @player1_char = ask_char("first")
        @player1 = Player.new(player1_name, player1_char,0)

        @player2_name = ask_name("second")
        @player2_char = ask_char("second")
        @player2 = Player.new(player2_name, player2_char,0)

    end

    def ask_name(order)
        if order == "first"
            puts "Please, enter the name of the first player: "
        elsif order == "second"
            puts "Please, enter the name of the second player: "
        end
        name = gets.chomp
    end

    def ask_char(order)
        if order == "first"
            puts "#{@player1_name}, please enter a character you want to play with, from 'a-z'"
        elsif order == "second"
            puts "#{@player2_name}, please enter a character you want to play with, from 'a-z'"
        end
        char = gets.chomp
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

start = Game.new()
p start




