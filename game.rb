require './player.rb'
require './computer.rb'

class Game
  def initialize()
    @secretCode = []
	@winner = false
	@codeBreaker = nil
	@codeMaker = nil
	@computer = Computer.new()
	@player = Player.new()
  end

  public
  def startGame()
    setupGame()

	playerGuess = nil

	while not @winner
	  if @codeBreaker == "player"
	    # have player guess code
		if playerGuess != nil
		  print "Your last guess was "
		  p playerGuess
		end
		playerGuess = @player.createOrGuessCode("guess")
		evalGuessResult = evalGuess(playerGuess)
		clearScreen()
		givePlayerFeedback(evalGuessResult)
	  elsif @codeBreaker == "computer"
	    # have computer guess code
		# have player give feedback in the form of 
		# preformatted messages
	  end
	end
  end

  private
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
	  @secretCode = @player.createOrGuessCode("create")
	elsif @codeMaker == "computer"
	  @secretCode = @computer.createCode()
	else
	  puts "ERROR GENERATING SECRET CODE IN setupGame()"
	end
  end

  # evaluates a code guess and returns feedback
  # 0 - indicates that there is a a wrong color that is not in the code
  # 1 - indicates that there is a right color in the correct position
  # 2 - indicates that there is a right color but in the wrong position
  def evalGuess(guess)
     result = []
	 guess.each_with_index do |color, cIndex|
	   if @secretCode[cIndex] == color
	     result.push(1)
	   elsif (@secretCode[cIndex] != color && @secretCode.any?(color))
	     result.push(2)
	   else
	     result.push(0)
	   end
	 end
	 return result
  end

  def givePlayerFeedback(guessResult)
    puts "You have #{guessResult.count(2)} correct colors in the correct position."
	puts "You have #{guessResult.count(1)} correct colors in the wrong position."
	puts "You have #{guessResult.count(0)} incorrect colors not included in the computer's code."
  end

  def clearScreen()
    print "\e[2J\e[f"
  end
end

game = Game.new()
game.startGame()
