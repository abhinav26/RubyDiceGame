require '/Users/abhinav/RubyDiceGame/game.rb'

describe Game do

	before :each do
		@game = Game.new(3)
	end

	describe "#new" do
		it "returns a new object with @number_of_players set as given in argument" do
			@game.should be_an_instance_of Game
			@game.instance_variable_get(:@number_of_players).should eql 3
		end

		it "throws error on passing invalid number of arguments" do
			lambda{Game.new(1,2)}.should raise_exception ArgumentError
			lambda{Game.new}.should raise_exception ArgumentError
		end

		it "checks if it initializes @final_round and @max_score" do
			@game.instance_variable_get(:@final_round).should eql false
			@game.instance_variable_get(:@max_score).should eql 0
		end
	end

	describe "#newgame" do
		it "checks that game doesnt start with less than 2 players" do
			@game = Game.new(0)
			Player.any_instance.should_not_receive(:new)
			@game.newgame
		end

		it "checks if game ends when final_round is true and final_counter reaches 0" do
			@game.instance_variable_set(:@final_round, true)
			@game.instance_variable_set(:@final_counter, 1)
			Player.any_instance.should_receive(:turn).with(no_args)
			@game.newgame
		end

	end

	describe "#play_next_turn" do
		it "checks if turn is called for the current player" do
			Player.any_instance.should_receive(:turn)
			player= Player.new
			@game.send(:play_next_turn , player)
		end

		it "sets @final_round to true when it is false and score > END_GAME_POINTS" do
			@game.instance_variable_set(:@final_round, false)
			player= Player.new
			player.score = 3100
			@game.send(:play_next_turn, player)
			@game.instance_variable_get(:@final_round).should eql true
		end
	end

	describe "#gameover?" do
		it "returns true if final_counter is 0" do
			@game.instance_variable_set(:@final_counter, 0)
			@game.send(:gameover?).should eql true
		end

		it "returns false if final_counter isnt 0" do
			@game.send(:gameover?).should eql false
		end
	end

	describe "#checklead" do
		it "returns true if final_counter is 0" do
			@game.instance_variable_set(:@final_counter, 0)
			@game.send(:gameover?).should eql true
		end

		it "returns false with any other string" do
			@game.send(:gameover?).should eql false
		end
	end


	describe "#winner_display" do
		it "returns correct values" do
			@game.instance_variable_set(:@leader,[1])
			@game.instance_variable_set(:@max_score, 3100)
			@game.send(:winner_display).should eql "The winner is Player1 with 3100 points"
			@game.instance_variable_set(:@leader,[1,2])
			@game.send(:winner_display).should eql "The winners are Players 1, 2 with 3100 points"
		end

	end
end
