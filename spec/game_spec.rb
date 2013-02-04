require 'game'
require 'board'
require 'console_io'

describe Game do

	let(:console_io) { ConsoleIo.new }

	describe '#valid_gamepiece' do
		xit 'should be false when the gamepiece is not an x or o' do
			console_io.stub(:grab_gamepiece => "y")
			subject.valid_gamepiece?.should be_false
		end

		xit 'should be true when the gamepiece is an x or o' do
			console_io.stub(:grab_gamepiece => "y")
			subject.valid_gamepiece?.should be_true
		end
	end
end