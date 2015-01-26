# This is a text-based adventure game
# It is based on 'Choose your own adventure'
puts <<END # Title Screen



          ***** ***** ** *****
          *     *   * ** *
          ***   ****  ** *
          *     *     ** *
          ***** *     ** *****

END

puts "press any key to continue..."
gets.chomp
print "\n" * 40 # Pretend user has jumped from Title Screen

puts "What is your name?"
name = gets.chomp # Set Name of our Hero

puts "Hi #{name}, you have been chosen by King Juha of Wynter Town to battle"
puts "the evil genius Edward of Taurus."
puts "Do you accept this quest?"

answer = gets.chomp
answer.downcase!

play_game = false # Flag to determine whether user wants to play or not
if answer.start_with? ('y') # If statement to give option to user whether to take quest or not
	puts "That's very brave of you #{name}"
	play_game = true
else
	puts "You should be ashamed! You are a coward!"
end

while play_game # If user wants to play (or keep playing) keep running game
	puts "You have arrived at Edward of Taurus' castle in Labcaster."
	puts "The villain appears at the main gate and begins to utter words you've never heard before."
	puts "You realize he is summoning For, the terrible monster that slows down"
	puts "its rivals until they freeze and turn to crystal, forever."
	print "\n" * 5

	puts "Fortunately, you recognize what is happening and think of various counterspells..."
	puts "What would you like to do?"
	puts "Options: summon eech, cast python, run away."

	answer = gets.chomp
	answer.downcase!

	case answer # Determine what happens based on user input
	when "summon eech"
		puts "You summon Eech, a much better monster than For, and kill both Evil Edward and its creature."
		puts "You are Wynter Town's new hero!"
		play_game = false # User wins, flag quits game.
	when "cast python"
		puts "Your Python spell is equal in strength to For's power."
		puts "Both you and Edward are drained of energy and both collapse."
		puts "You wake up at Wynter Town and need to decide whether to fight again or retire."
		puts "Would you like to try again?"
		answer = gets.chomp
		answer.downcase!
		if answer.start_with? ('y') # user can decide whether to keep playing or quit
			play_game = true
			print "\n" * 5
		else
			play_game = false
			puts "That's too bad, you were very close."
		end
	when "run away" 
		puts "You run away, however, you are too slow and Edward kills you."
		play_game = false # User has lost the game
	else # Alternate scenario
		puts "You can only muster a few words but are too slow."
		puts "For overpowers you and you die."
		puts "Valiant effort, you will always be remembered."
		play_game = false
	end # End Case

end # End While loop
