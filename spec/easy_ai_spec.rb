require 'easy_ai'

describe EasyAi do

	it "should inherit from player" do
		described_class.ancestors.should include(Player)
	end

end