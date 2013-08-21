require 'dice.rb'

class Player
  attr_accessor :score

  START_THRESHOLD = 300
  START_NUMBER_OF_DIE = 5

  def initialize
  	@started_scoring=false
  	@score=0
  end

  def turn
  	dice = DiceSet.new
  	non_scoring = 0
  	turn_score = 0
  	num_of_die = START_NUMBER_OF_DIE

  	while true
		  dice.roll(num_of_die)
		  roll_score = dice.roll_score
		  non_scoring = dice.non_scoring
		  puts "\t"+dice.values.inspect
		  puts "\t"+roll_score.inspect
		  puts "\t"+non_scoring.inspect

		  if @started_scoring == false 
		  	if roll_score < START_THRESHOLD 
		  	  return
		  	else
		  	  @started_scoring = true
		  	end
		  end
		  
		  if non_scoring == num_of_die
		  	return
		  elsif non_scoring > 0
		  	num_of_die = non_scoring
		  end

		  turn_score = turn_score + roll_score

		  break if !roll_again?
		end
		@score +=turn_score
  end

  def roll_again?
  	puts "Again?"
		str = gets.chomp
		puts str
		if str.downcase == "yes"
			return true
		else
			return false
		end
  end

  private :roll_again?

end