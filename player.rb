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

  	begin
		  dice.roll(num_of_die)
		  roll_score = dice.roll_score
		  non_scoring = dice.non_scoring
		  puts "\t"+dice.values.inspect
		  puts "\t"+roll_score.inspect
		  puts "\t"+non_scoring.inspect

		  return if !check_scoring_started?(roll_score)
		  return if non_scoring == num_of_die
		  num_of_die = non_scoring if non_scoring > 0

		  turn_score = turn_score + roll_score
		end while roll_again?

		@score += turn_score
  end

  def check_scoring_started?(roll_score)
  	return true if @started_scoring == true
  	return false if roll_score < START_THRESHOLD 
  	@started_scoring = true
  	return true
	end



  def roll_again?
  	puts "Again?"
		str = gets.chomp
		if str.downcase == "yes"
			return true
		else
			return false
		end
  end

  private :roll_again? , :check_scoring_started?

end