require 'console_io'

describe ConsoleIo do
	before {
		subject.input = StringIO.new
		subject.output = StringIO.new
	}

	describe '#display_welcome_message' do
		it 'should display a welcome message when the game starts' do
	  	subject.should_receive(:display)
	  	subject.display_welcome_message
		end
	end

	describe '#display_empty_gameboard' do
		it 'should display an empty gameboard when the game starts' do
			subject.should_receive(:display)
			subject.display_empty_gameboard
		end
	end

	describe '#display_invalid_gamepiece' do
		it 'should display an invalid gamepiece message when the gamepiece is not an x or o' do
			subject.should_receive(:display)
			subject.display_invalid_gamepiece
		end	
	end

	describe '#grab_gamepiece' do
		it 'should prompt the player to choose between x and o' do
			subject.should_receive(:prompt)
			subject.grab_gamepiece
		end	
	end

end