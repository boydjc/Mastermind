class Player
  def initialize(); end

  # creates a code for the player to guess
  # choices to pick are 
  # 0 - red        5 - blue
  # 1 - green      6 - yellow
  # 2 - purple     7 - white
  # 3 - black      8 - blank
  # 4 - orange     9 - pink
  def createCode()
    code = []
	while code.length < 4

	  if code.length > 0
	    print "Your current code is: "
		p code
		puts "You have #{4 - code.length} choices remaining."
	  end
	  
      puts "\nChoose your color for slot #{code.length+1}."
	  puts "The choices for your code are the following:"
	  puts "0 - red \t 5 - blue"
	  puts "1 - green \t 6 - yellow"
	  puts "2 - purple \t 7 - white"
	  puts "3 - black \t 8 - blank"
	  puts "4 - orange \t 9 - pink"
	  print ":"
	  choice = gets.chomp
	  case choice.to_i
	  when 0
	    puts "Red selected for slot #{code.length+1}."
	    code.push("red")
	  when 1
	    puts "Green selected for slot #{code.length+1}."
	    code.push("green")
	  when 2
	    puts "Purple selected for slot #{code.length+1}."
	    code.push("purple")
	  when 3
	    puts "Black selected for slot #{code.length+1}."
	    code.push("black")
	  when 4
	    puts "Orange selected for slot #{code.length+1}."
	    code.push("orange")
	  when 5
	    puts "Blue selected for slot #{code.length+1}."
	    code.push("blue")
	  when 6
	    puts "Yellow selected for slot #{code.length+1}."
	    code.push("yellow")
	  when 7
	    puts "White selected for slot #{code.length+1}."
	    code.push("white")
	  when 8
	    puts "Slot #{code.length+1} was left blank."
	    code.push("blank")
	  when 9
	    puts "Pink selected for slot #{code.length+1}."
	    code.push("pink")
	  else
	    puts "That is an invalid choice"
	  end
	end
	return code
  end
end
