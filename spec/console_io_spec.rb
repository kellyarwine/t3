require 'spec_helper'

describe ConsoleIo do
	before {
		subject.input = StringIO.new
		subject.output = StringIO.new
	}

	let(:board) { Board.new }
	let(:subject) { ConsoleIo.new(board) }

		it 'displays a message' do
	  	subject.output.should_receive(:puts)
	  	subject.display("Hi")
		end

		it 'displays a message and accepts input' do
			subject.output.should_receive(:puts).with("Hi")
			subject.input.should_receive(:gets).and_return("hello\n")
			subject.display_and_get("Hi")
		end

		it 'displays a gameboard' do
			subject.should_receive(:display)
			subject.display_gameboard
		end

		xit 'prompts for a move' do
			subject.should_receive(:display)
			subject.should_receive(:gets).and_return(9)
			subject.display_and_get_move
		end

		it 'displays an invalid move message' do
			subject.should_receive(:display)
			subject.display_invalid_move
		end

end