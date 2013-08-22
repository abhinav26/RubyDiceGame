require 'player.rb'

class Game
  
  END_GAME_POINTS = 3000
  def initialize(number_of_players)
  	@final_round = false
  	@max_score = 0
  	@leader = []
  	@final_counter = number_of_players-1
    @number_of_players =number_of_players
  end

  def newgame
    puts "Atleast 2 players required" && return if @number_of_players < 2

  	players = Array.new
  	for i in 0..@number_of_players
  	  players[i] = Player.new
  	end
  	counter = 0

  	begin
      puts "Player #{counter} score : #{players[counter].score}"
	  	play_next_turn(players[counter])
      check_lead(counter, players[counter].score)
      counter = (counter + 1) % @number_of_players
  	end while !gameover?

    puts winner_display
  end

  def play_next_turn(player)
    player.turn
    
    if @final_round == true
      @final_counter -= 1
    elsif player.score >= END_GAME_POINTS
      @final_round = true
    end
  end

  def gameover?
  	return true if @final_counter == 0  		
    return false
  end

  def check_lead (i, score)
  	if score > @max_score
  		@leader = [i]
  		@max_score = score
  	elsif score == @max_score
  		@leader << i
  	end
  end

  def winner_display
    if @leader.size>1
      "The winners are Players #{@leader.join(", ")} with #{@max_score} points"
    else
      "The winner is Player#{@leader[0]} with #{@max_score} points"
    end
  end

  private :check_lead , :winner_display , :gameover?

end
