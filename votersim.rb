# Voter Simulator

class District
	def initialize
		@voters = []
		@politicians = []
		@votes_republican = []
		@votes_democrat = []
	end

	def create_parameters # Needed to test without input all the time
		puts "What would you like to create? Politician or Voter."
		response = gets
		if response.nil?
			response = ["Politician", "Voter"].sample
		else
			response = response.chomp.downcase.capitalize!
		end
		new_human = create(response)
		if new_human.nil? 
			puts "Please select a valid entry."
			create_parameters
		end
		return new_human
	end

	def create(response)
		if response == 'Politician'
			Politician.new
		elsif response == 'Voter'
			Person.new
		else
			nil
		end # If End
	end # Create End

	def list(people_list, politician_list)
		(people_list + politician_list).each { |human| puts "Name: #{human.name} -- Party: #{human.party} -- Type: #{human.human_type} -- Current Vote: #{human.vote}" }
	end 

	def update
		puts "What would you like to update? Voter or Politician."
		response = gets.chomp.downcase.capitalize!
		if response == "Politician"
			puts "Who would you like to update?"
			response = gets.chomp.downcase.capitalize!
			update_politician(response)
		elsif response == "Voter"
			puts "Who would you like to update?"
			response = gets.chomp.downcase.capitalize!
			update_voter(response)
		else
			puts "Please select a valid entry."
			update()
		end
	end

	def update_politician(person)
		@politicians.each do |politician|
			if politician.name == person
				puts "Would you like to update their name?"
				response = gets.chomp.downcase
				if response.start_with?('y')
					puts "New name?"
					politician.name = gets.chomp.downcase.capitalize!
				end   
				puts "Would you like to update their views?"
				response = gets.chomp.downcase
				if response.start_with?('y')
					puts "New party?"
					politician.party = gets.chomp.downcase.capitalize!
				end
				return # Return here to exit without calling puts 
			end	
		end
		puts "No such entry was found."
	end

	def update_voter(person)
		@voters.each do |voter|
			if voter.name == person
				puts "Would you like to update their name?"
				response = gets.chomp.downcase
				if response.start_with?('y')
					puts "New name?"
					voter.name = gets.chomp.downcase.capitalize!
				end
				puts "Would you like to update their views?"
				response = gets.chomp.downcase
				if response.start_with?('y')
					new_party = gets.chomp.downcase.capitalize!
				end
				return # Return here to exit without calling puts
			end
			puts "No such entry was found."
		end
	end

	def vote
		@politicians.each do |politician|
			(@voters + @politicians).each do |person|
				if person.human_type == "Politician"
					puts "I condemn this statement!"
					puts
				else
					random_num = Random.new.rand(100) / 100.0
					person.listen_to_politician(politician, random_num)
				end
			end
		end
		tally()
	end

	def tally
		(@voters + @politicians).each do |person|
			if person.vote == "Democrat"
				@votes_democrat << person
			end
			if person.vote == "Republican"
				@votes_republican << person
			end
		end

		if @votes_democrat.size > @votes_republican.size
			puts "Congratulations to the Democratic Party. They are now in control of Congress."
			puts "The race was won by  #{@votes_democrat.size} to #{@votes_republican.size}."
			puts
		elsif @votes_democrat.size < @votes_republican.size
			puts "Congratulations to the Republican Party. They are now in control of Congress."
			puts "The race was won by  #{@votes_republican.size} to #{@votes_democrat.size}."

			puts
		else
			puts "There's a standoff and no party has been able to gain control of Congress."
			puts "The vote ended in a tie of #{@votes_democrat.size} to #{@votes_republican.size}."
			puts
		end
	end

	def start_simulation
		puts "Welcome to the Voter Simulator for 2015. Please select from one of the options below."
		while true
			puts "               [Create] [List] [Update] [Vote] [Exit]"
			response = gets
			response = if response.nil?
				%w[Create List Update Vote].sample
			else
				response.chomp.downcase.capitalize!
			end

			case response
			when "Create"
				new_human = create_parameters()
				if new_human.is_a? Politician
					@politicians << new_human
				else
					@voters << new_human
				end
			when "List"
				list(@voters, @politicians)
			when "Update"
				update()
			when "Vote"
				vote()
			when "Exit"
				exit()
			else
				puts "Please select a valid entry."
			end # Case End

		end # While Loop End
	end

end # Disctrict Class End

##################### CLASSES MODULE #####################
class Human
	attr_accessor :name, :party, :human_type
	# def entry_ok?(value)
	# 	if value.is_alpha?
	# 		value
	# 	else
	# 		puts "Please use only characters for your response."
	# 	end
	# end

	def set_name
		response = false
		while not response
			puts "What is your name?"
			response = gets.chomp.downcase.capitalize!
			# entry_ok?(response) # Need to implement is_alpha check 
		end
		response
	end

	def show_status
		puts @name
		puts @party
		puts @human_type
	end

end

class Person < Human
	attr_accessor :vote

# - 90% chance of convincing a Socialist voter to vote for him
# - 75% chance of convincing a Liberal voter to vote for him
# - 50% chance of convincing a Neutral voter to vote for him
# - 25% chance of convincing a Conservative voter to vote for him
# - 10% chance of convincing a Tea Party voter to vote for him

	DEMOCRAT_STATS = { "Socialist" => 0.90,
					   "Liberal" => 0.75,
					   "Neutral" => 0.50,
					   "Conservative" => 0.25,
					   "Tea party" => 0.10 }

# - 90% chance of convincing a Tea Party voter to vote for him
# - 75% chance of convincing a Conservative voter to vote for him
# - 50% chance of convincing a Neutral voter to vote for him
# - 25% chance of convincing a Liberal voter to vote for him
# - 10% chance of convincing a Socialist voter to vote for him

	REPUBLICAN_STATS = { "Tea party" => 0.90,
						 "Conservative" => 0.75,
						 "Neutral" => 0.50,
						 "Liberal" => 0.25,
						 "Socialist" => 0.10 }

	def initialize
		@name = set_name
		@party = set_views
		@human_type = "Voter"
		@vote = nil
	end # initialize End

	def set_views
		response = false
		while not response
			puts "Please select your political views: Liberal, Conservative, Tea Party, Socialist or Neutral."
			response = gets.chomp.downcase.capitalize!
			# entry_ok?(response) # need to implement is_alpha check
		end # While End
		response
	end # set_views End

	def listen_to_politician(politician, random_num)
		case politician.party
		when "Democrat"
			likelihood = DEMOCRAT_STATS[@party]
		when "Republican"
			likelihood = REPUBLICAN_STATS[@party]
		else
			puts "This shouldn't happen!"
		end

		if (random_num <= likelihood)
			@vote = politician.party
			puts "After listening to this politician, I have to say I will end up voting for him."
			puts
		else
			puts "I have not been persuaded."
			puts
		end
	end

end # Person Class End

class Politician < Human
	attr_reader :party, :vote

	def initialize
		@name = set_name
		@party = set_views
		@human_type = "Politician"
		@vote = @party
	end

	def set_views
		response = false
		while not response
			puts "Please select your party: Democrat or Republican:"
			response = gets.chomp.downcase.capitalize!
			# entry_ok?(response) # need to implement is_alpha check
		end
		response
	end
end

##################### FUNCTIONS MODULE #####################

miami = District.new
miami.start_simulation
