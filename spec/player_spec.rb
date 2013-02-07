require 'spec_helper'

describe Player do
	it 'has a piece' do
		Player.new("x").piece.should == "x"
	end
end