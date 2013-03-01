require 'spec_helper'

describe Player do
	let(:gamepiece) { "x" }
	let(:subject) { Player.new(gamepiece) }

	it 'has a piece' do
		Player.new("x").piece.should == gamepiece
	end
	
end