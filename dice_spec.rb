require '../dice.rb'

describe DiceSt do
	
	before :each do
		@dice = DiceSet.new
	end

	describe "#new" do
		it "returns a new object" do
			@dice.should_not be_an_instance_of DiceSet
		end
	end

 
end