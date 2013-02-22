require 'spec_helper'

describe Human do

	let(:subject) 			{ Human.new("x","Player 1") }

	it "should inherit from player" do
		described_class.ancestors.should include(Player)
	end

end