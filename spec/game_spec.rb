require 'game'

describe Game do
	let!(:console_io) { ConsoleIo.new }
	let!(:board) { Board.new }

	it "prompts for move, places move and prints board when the game runs" do
		subject.should_receive(:prompt_for_move)
		subject.should_receive(:place_move)
		subject.should_receive(:print_board)
		subject.run
	end

	it "displays a gameboard" do
		ConsoleIo.stub(:new) { console_io }
		console_io.should_receive(:display_gameboard)
		subject.print_board
	end

	it "prompts the user for a move" do
		ConsoleIo.stub(:new) { console_io }
		console_io.should_receive(:prompt_for_move)
		subject.prompt_for_move
	end

	it "prints the board with the move" do
		Board.stub(:new) { board }
		board.should_receive(:place_move)
		subject.place_move
	end		

end