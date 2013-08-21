require 'player.rb'

class Game
  def initialize
  	@final_round = false
  	@max_score = 0
  	@leader = []
    @points_barrier = 3000
  	@final_counter = 0
  end

  def newgame(number_of_players)
  	if number_of_players<2
  		puts "Atleast 2 players required"
  	  	return
  	end

  	@final_counter=number_of_players-1
  	players = Array.new

  	for i in 0..number_of_players
  	  	players[i] = Player.new
  	end

  	counter = 1
  	while true
	  	puts "Player #{counter} score : #{players[counter].score}"
	  	players[counter].turn
	  	
	  	if @final_round != true && players[i].score >= @points_barrier
	  		@final_round = true
	  	elsif @final_round == true
	  		@final_counter -=1
	  	end

	  	check_lead(counter,players[counter].score)
	  	if counter == number_of_players
	  		counter = 1
	  	else
	  		counter += 1
	  	end
	  	break if gameover?
  	end
    
  	if @leader.size>1
  		puts "The winners are Players #{@leader.join(", ")} with #{@max_score} points"
  	else
  		puts "The winner is Player#{@leader[0]} with #{@max_score} points"
  	end
  end

  def gameover?
  	if @final_counter == 0
  		return true
  	else
  		return false
  	end
  end

  def check_lead (i, score)
  	if score > @max_score
  		@leader = [i]
  		@max_score = score
  	elsif score == @max_score
  		@leader << i
  	end
  end
end
