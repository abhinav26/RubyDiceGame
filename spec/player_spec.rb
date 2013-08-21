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
	 	it 

	describe "#roll_again?" do
		it "returns true with input 'yes' or'YES' or 'Yes' " do
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("yes")
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("YES")
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("Yes")
			@player.send(:roll_again?).should eql true
			@player.send(:roll_again?).should eql true
			@player.send(:roll_again?).should eql true
		end

		it "returns false with any other string" do
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("yesss")
			Player.any_instance.should_receive(:gets).with(no_args()).and_return("nah")
			@player.send(:roll_again?).should eql false
			@player.send(:roll_again?).should eql false
		end

	end
end