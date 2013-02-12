require 'spec_helper'

describe Game do
	let(:board) 			{ Board.new }
	let(:console_io)	{ ConsoleIo.new(board) }

	context "setup game" do
		it "creates an instance of board" do
			subject.board.should be_kind_of(Board)
		end

		it "creates an instance of console_io" do
			subject.console_io.should be_kind_of(ConsoleIo)
		end

		it "creates an instance of player" do
			subject.player_1.should be_kind_of(Player)
		end

		it "creates an second instance of player" do
			subject.player_2.should be_kind_of(Player)
		end

		it "creates a instance of current_players with two players" do
			subject.current_players.should == [subject.player_1,subject.player_2]
		end

		it "sets player 1 as the first player" do
			subject.current_player.should == subject.player_1
		end

	end

	context "#run" do
		it "displays welcome message" do
			subject.console_io.should_receive(:display_welcome_message)
			subject.display_welcome_message
		end

		it "prompts for move when the game runs" do
			subject.should_receive(:display_and_get_move).exactly(9)
			subject.stub(:place_move)
			subject.stub(:valid_move? => true)
			subject.stub(:print_board)
			subject.run
		end

		it "places move when the game runs" do
			subject.stub(:display_and_get_move)
			subject.should_receive(:place_move).exactly(9)
			subject.stub(:valid_move? => true)
			subject.stub(:print_board)
			subject.run
		end

		it "prints board when the game runs" do
			subject.stub(:display_and_get_move)
			subject.stub(:place_move)
			subject.stub(:valid_move? => true)
			subject.should_receive(:print_board).exactly(9)
			subject.run
		end

		it "validates a move when the game runs" do
			subject.stub(:display_and_get_move)
			subject.should_receive(:valid_move?).exactly(9).and_return(true)
			subject.stub(:place_move)
			subject.stub(:print_board)
			subject.run
		end

		it "displays invalid move message when game runs and move is invalid" do
			subject.stub(:display_and_get_move)
			subject.stub(:valid_move?).and_return(false,true)
			subject.should_receive(:display_invalid_move)
			subject.stub(:place_move)
			subject.stub(:print_board)
			subject.run
		end
	end

	it "displays a gameboard" do
		subject.console_io.should_receive(:display_gameboard)
		subject.print_board
	end

	it "prompts the user for a move and gets move" do
		subject.console_io.should_receive(:display_and_get_move).with(subject.current_player.piece)
		subject.display_and_get_move
	end

	it "prints the board with the move" do
		subject.board.should_receive(:place_move)
		subject.place_move
	end

	it "validates a player move" do
		subject.move = 9
		subject.board.should_receive(:valid_move?)
		subject.valid_move?
	end

	it "display an invalid move message" do
		subject.console_io.should_receive(:display_invalid_move)
		subject.display_invalid_move
	end

	context "#current_player" do
		it "sets the current player to player_1" do
			subject.switch_current_player
			subject.current_player.should == subject.player_2
		end

		xit "sets the current player to player_2 when called twice" do
			subject.switch_current_player
			subject.current_player.should == subject.player_1
		end
	end
end