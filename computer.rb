class Computer
  def initialize();end

  # creates a code for the player to guess
  # choices to pick are 
  # 0 - red        5 - blue
  # 1 - green      6 - yellow
  # 2 - purple     7 - white
  # 3 - black      8 - blank
  # 4 - orange     9 - pink
  def createCode()
    code = []
	for i in 0..3
	  choice = rand(0..9)
	  case choice
	  when 0
	    code.push('red')
	  when 1
	    code.push('green')
	  when 2
	    code.push('purple')
	  when 3
	    code.push('black')
	  when 4
	    code.push('orange')
	  when 5
	    code.push('blue')
	  when 6
	    code.push('yellow')
	  when 7
	    code.push('white')
	  when 8
	    code.push('blank')
	  when 9
	    code.push('pink')
	  else
	    puts "ERROR GENERATING CODE COLOR CHOICE FOR COMPUTER"
	  end
	end
	return code
  end
end
