require 'spec_helper'

describe Player do
	it 'has a piece' do
		Player.new("x", "Player 1").piece.should == "x"
	end

	it 'has a name' do
		Player.new("x", "Player 1").name.should == "Player 1"
	end	
end