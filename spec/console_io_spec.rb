require 'spec_helper'

describe ConsoleIo do
	before {
		subject.input = StringIO.new
		subject.output = StringIO.new
	}

	let(:board) 				{ Board.new }
	let(:subject) 			{ ConsoleIo.new(board) }

		it 'displays a message' do
	  	subject.output.should_receive(:puts)
	  	subject.display("Hi")
		end

		it 'displays a message' do
			subject.output.should_receive(:puts).with("Hi")
			subject.input.stub(:gets => "9\n")
			subject.display_and_get("Hi")
		end

		it 'returns an integer' do
			subject.stub(:display)
			subject.input.stub(:gets).and_return("9\n")
			subject.display_and_get("Hi").should == 9
		end

		it 'displays a welcome message' do
			subject.should_receive(:display)
			subject.display_welcome_message
		end

		it 'displays a gameboard' do
			subject.should_receive(:display)
			subject.display_gameboard
		end

		it 'prompts player_1 for a move' do
			subject.should_receive(:display).with("Player 1, please enter a move (1-9):")
			subject.input.stub(:gets).and_return("9\n")
			subject.display_and_get_move("x")
		end

		it 'prompts player_2 for a move' do
			subject.stub(:display)
			subject.input.stub(:gets).and_return("9\n")
			subject.display_and_get_move("o")
		end

		it 'displays an invalid move message' do
			subject.should_receive(:display)
			subject.display_invalid_move
		end

end