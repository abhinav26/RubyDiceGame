require '/Users/abhinav/Dice Game Ruby/dice.rb'

describe DiceSet do
	
	before :each do
		@dice = DiceSet.new
	end

	describe "#new" do
		it "returns a new object" do
			@dice.should be_an_instance_of DiceSet
		end

		it "throws error on passing any arguments" do
			lambda{DiceSet.new "arg1" "arg2"}.should raise_exception ArgumentError
		end
	end

	describe "#roll" do
		it "throws error on passing any arguments" do
			lambda{@dice.roll(1,2)}.should raise_exception ArgumentError
			lambda{@dice.roll()}.should raise_exception ArgumentError
		end

		it "creates an array of size equal to value of rolls argument" do
			@dice.roll(5)
			@dice.values.size.should eql 5
		end

		it "creates an array where each value is between 1 and 6" do
			@dice.roll(5)
			@dice.values.each do |i|
				(1..6).should include i
			end
		end
	end

	describe "#calculate_score" do
		it "checks for edge cases in roll score" do
			@dice.values = [1,1,1,1,1]
			@dice.calculate_score(5)
			@dice.roll_score.should eql 1200 

			@dice.values = [2,3,6,3,2]
			@dice.calculate_score(5)
			@dice.roll_score.should eql 0  
		end

		it "checks in random cases if roll score is in range" do
			10.times do
				@dice.roll(5)
				@dice.roll_score.should <= 1200 
				@dice.roll_score.should >= 0 
			end
		end		
		
		it "checks for cases with 3 or more ones or fives" do
			@dice.values = [1,1,1,1,2]
			@dice.calculate_score(5)
			@dice.roll_score.should eql 1100 

			@dice.values = [1,5,5,5,2]
			@dice.calculate_score(5)
			@dice.roll_score.should eql 600 
		end

		it "checks for cases with 3 of other numbers" do
			@dice.values = [1,2,2,3,2]
			@dice.calculate_score(5)
			@dice.roll_score.should eql 300 
		end

		it "checks for score with different sizes of values" do
			@dice.values = [1,2,5]
			@dice.calculate_score(3)
			@dice.roll_score.should eql 150

			@dice.values = [5]
			@dice.calculate_score(3)
			@dice.roll_score.should eql 50

			@dice.values = []
			@dice.calculate_score(3)
			@dice.roll_score.should eql 0
		end
	end

	describe "#calculate_subscore" do
		it "returns 1000 on exactly 3 ones and 500 on exactly 3 fives" do
			@dice.send(:calculate_subscore, 3, 1000, 100).should eql 1000
			@dice.send(:calculate_subscore, 3, 500, 50).should eql 500
		end

		it "returns correct score on more than three ones and fives" do
			@dice.instance_eval{calculate_subscore(4, 1000, 100)}.should eql 1100
			@dice.instance_eval{calculate_subscore(4, 500, 50)}.should eql 550
		end

		it "returns correct score on less than three ones and fives" do
			@dice.send(:calculate_subscore, 2, 1000, 100).should eql 200
			@dice.send(:calculate_subscore, 1, 500, 50).should eql 50
		end

	end
 
end