require '/Users/abhinav/RubyDiceGame/player.rb'

describe Player do

	before :each do
		@player = Player.new
	end

	describe "#new" do
		it "returns a new object" do
			@player.should be_an_instance_of Player
		end

		it "throws error on passing any arguments" do
			lambda{Player.new "arg1" "arg2"}.should raise_exception ArgumentError
		end

		it "initializes score to zero" do
			@player.score.should eql 0
		end
	end

	describe "#turn" do
		it "stops if all die are non_scoring" do
			DiceSet.any_instance.should_receive(:roll_score).with(no_args()).and_return(0)
			DiceSet.any_instance.should_receive(:non_scoring).with(no_args()).and_return(5)
			@player.turn
			@player.score.should eql 0
		end

		it "score remains zero if roll_score > 300 and non_scoring become 0 in next roll" do
			puts "0"
			DiceSet.any_instance.should_receive(:roll_score).with(no_args()).and_return(400, 0)
			DiceSet.any_instance.should_receive(:non_scoring).with(no_args()).and_return(2, 2)
			Player.any_instance.should_receive(:roll_again?).with(no_args()).and_return(true)
			# DiceSet.any_instance.should_receive(:roll_score).with(no_args()).and_return(0)
			# DiceSet.any_instance.should_receive(:non_scoring).with(no_args()).and_return(2)
			@player.turn
			@player.score.should eql 0
		end

		it "accumulates scores" do
			puts "0"
			DiceSet.any_instance.should_receive(:roll_score).with(no_args()).and_return(1200, 100, 200)
			DiceSet.any_instance.should_receive(:non_scoring).with(no_args()).and_return(0, 3, 1)
			Player.any_instance.should_receive(:roll_again?).with(no_args()).and_return(true, true, false)
			@player.turn
			@player.score.should eql 1500
		end

	end

	describe "#check_scoring_started?" do
	 	it "returns true if @started_scoring is true" do
	 		@player.instance_variable_set(:@started_scoring, true)
	 		@player.send(:check_scoring_started?, 400).should eql true 
	 	end

	 	it "returns false if @started_scoring is false and roll_score < 300" do
	 		@player.instance_variable_set(:@started_scoring, false)
	 		@player.send(:check_scoring_started?, 200).should eql false
	 	end

	 	it "returns true if @started_scoring is false and roll_score >= 300" do
	 		@player.instance_variable_set(:@started_scoring, false)
	 		@player.send(:check_scoring_started?, 450).should eql true
	 		@player.send(:check_scoring_started?, 300).should eql true
	 	end

	end

	describe "#roll_again?" do
		it "returns true with input 'yes' or'YES' or 'Yes' " do
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("yes", "YES" , "Yes")
			# Player.any_instance.should_receive(:gets).with(no_args()).and_return("YES")
			# Player.any_instance.should_receive(:gets).with(no_args()).and_return("Yes")
			@player.send(:roll_again?).should eql true
			@player.send(:roll_again?).should eql true
			@player.send(:roll_again?).should eql true
		end

		it "returns false with any other string" do
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("yesss", "no")
			@player.send(:roll_again?).should eql false
			@player.send(:roll_again?).should eql false
		end

	end
end