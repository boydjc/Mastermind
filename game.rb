require './player.rb'
require './computer.rb'

class Game
  def initialize()
    @secretCode = []
	@codeBreaker = nil
	@codeMaker = nil
	@computer = Computer.new()
	@player = Player.new()
  end

  def setupGame()
    # pick roles
    while @codeBreaker == nil && @codeMaker == nil
      puts "\nPlayer. Are you the codebreaker or codemaker?"
	  puts "[1] - Codebreaker \t [2] - Codemaker"
	  print ":"
	  playerChoice = gets.chomp.to_i
	  if playerChoice == 1
	    @codeBreaker = "player"
        @codeMaker = "computer"
	  elsif playerChoice == 2
	    @codeBreaker = "computer"
	    @codeMaker = "player"
	  else
	    puts "That is an invalid choice."
	  end
	end

	# create code
	if @codeMaker == "player"
	  @secretCode = @player.createCode()
	elsif @codeMaker == "computer"
	  @secretCode = @computer.createCode()
	else
	  puts "ERROR GENERATING SECRET CODE IN setupGame()"
	end

	p @secretCode
  end
end

game = Game.new()
game.setupGame()
