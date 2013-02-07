require 'spec_helper'

describe Game do
	let(:board) { Board.new }
	let(:console_io) {ConsoleIo.new(board) }

	it "prompts for move, places move and prints board when the game runs" do
		subject.should_receive(:prompt_for_move).exactly(9)
		subject.should_receive(:place_move).exactly(9)
		subject.should_receive(:print_board).exactly(9)
		subject.run
	end

	it "displays a gameboard" do
		subject.console_io.should_receive(:display_gameboard)
		subject.print_board
	end

	it "prompts the user for a move" do
		subject.console_io.should_receive(:prompt_for_move)
		subject.prompt_for_move
	end

	it "prints the board with the move" do
		subject.board.should_receive(:place_move)
		subject.place_move
	end		

end