require './player.rb'
require './computer.rb'

class Game
  def initialize()
    @secretCode = []
	@codeColorOccurances = Hash.new(0)
	@winner = false
	@codeBreaker = nil
	@codeMaker = nil
	@computer = Computer.new()
	@player = Player.new()
	@guessNums = 0
  end

  public
  def startGame()
    setupGame()

	playerGuess = nil

	while not @winner and @guessNums < 12

      if @guessNums == 11
	    if @codeBreaker == "player"
		  puts "Sorry. You failed to break the computer's code."
		  break
		elsif @codeBreaker == "computer"
		  puts "Congrats. The computer was not able to crack your code!"
		  break
		end
	  end

	  if @codeBreaker == "player"
	    puts "--------------------------------"
	    # have player guess code
		if playerGuess != nil
		  print "Your last guess was "
		  p playerGuess
		end
		puts "You have #{12 - @guessNums} guesses remaining."
		playerGuess = @player.createOrGuessCode("guess")
		@guessNums += 1
		evalGuessResult = evalGuess(playerGuess)
		clearScreen()
		givePlayerFeedback(evalGuessResult)
	  elsif @codeBreaker == "computer"
	    # have computer guess code
		computerGuess = @computer.createOrGuessCode()
		puts "Computer guesses "
		p computerGuess
		@guessNums += 1
		evalGuessResult = evalGuess(computerGuess)
	  end
	end
  end

  private
  def setupGame()
    guessNums = 0
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
	  @secretCode = @computer.createOrGuessCode()
	else
	  puts "ERROR GENERATING SECRET CODE IN setupGame()"
	end

	setColorOccurances()
  end

  # evaluates a code guess and returns feedback
  # 0 - indicates that there is a a wrong color that is not in the code
  # 1 - indicates that there is a right color but in the wrong position
  # 2 - indicates that there is a right color in the correct position

  def evalGuess(guess)
    result = []

	# we need to check the occurance of the colors in the code
    # in relation with the colors in the guess
    # for example if we have two "reds" we need to make sure that
    # the check does not count the first "red" if it has already been 
    # accounted for in previous iterations
	guess.each_with_index do |color, cIndex|
	  if @secretCode[cIndex] == color
	    result.push(2)
	  elsif (@secretCode[cIndex] != color)
	    # check to see if the color is somewhere in the code
	    if @secretCode.any?(color)
		  colorGuessOccurance = 0
		  # count how many times is this time we are seeing this color
		  for i in 0..cIndex
		    if guess[i] == color
			  colorGuessOccurance += 1
			end
		  end
		  # if the times we have seen this color is less 
		  # than or equal to the max number of occurances
		  # of the color in the secret code then we can proceed
		  # with the feedback message
		  if colorGuessOccurance <= @codeColorOccurances[color]
            result.push(1)
		  else
		    result.push(0)
		  end
		else
		  result.push(0)
		end
	  end
	end
    return result
  end

  # counts the number of occurances for each color 
  # in the secret code. This is used later when evaluating 
  # guesses
  def setColorOccurances()
    @codeColorOccurances = Hash.new(0)	
	@secretCode.each do |color|
	  @codeColorOccurances[color] += 1
	end
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
