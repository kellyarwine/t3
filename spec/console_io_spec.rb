require 'spec_helper'

describe ConsoleIo do
	before {
		subject.input = StringIO.new
		subject.output = StringIO.new
	}

	let(:board) 				{ Board.new(9) }
	let(:subject) 			{ ConsoleIo.new(board) }
	let(:player_1) 			{ Player.new("o", "Human") }

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
		subject.stub(:puts)
		subject.input.stub(:gets).and_return("9\n")
		subject.display_and_get("Hi").should == "9"
	end

	it 'prompts the player for their choice of opponent and receives their input' do
		subject.output.should_receive(:puts).with("Choose your opponent:\n\n")
		subject.output.should_receive(:puts).with("1. AI Player (Easy)\n")
		subject.output.should_receive(:puts).with("2. Human Player\n\n")
		subject.input.should_receive(:gets).and_return("1\n")
		subject.display_and_get_opponent.should == "1"
	end	

	it 'prompts the player for their board choice and receives their input' do
		subject.output.should_receive(:puts).with("Choose the board size:\n\n")
		subject.output.should_receive(:puts).with("1. 3x3\n")
		subject.output.should_receive(:puts).with("2. 4x4\n")
		subject.output.should_receive(:puts).with("3. 5x5\n\n")
		subject.input.should_receive(:gets).and_return("1\n")
		subject.display_and_get_board.should == "1"
	end	

	it "displays an invalid board message" do
		subject.output.should_receive(:puts).with("Invalid board.  Please try again.")
		subject.display_invalid_board
	end

	it 'prompts the player for their gamepiece choice and receives their input' do
		subject.output.should_receive(:puts).with("Player 1, what 1-character symbol would you like for your gamepiece?")
		subject.input.should_receive(:gets).and_return("Y\n")
		subject.display_and_get_gamepiece("Player 1")
	end

	it 'displays an invalid gamepiece message' do
		subject.output.should_receive(:puts).with("Invalid gamepiece.  Please try again.")
		subject.display_invalid_gamepiece
	end

	it 'displays a welcome message' do
		subject.output.should_receive(:puts)
		subject.display_welcome_message
	end

	it 'prompts player 1 for a move' do
		subject.output.should_receive(:puts).with("Human, please enter a move (1-9):")
		subject.input.should_receive(:gets).and_return("9\n")
		subject.display_and_get_move(player_1)
	end

	it 'displays a gameboard' do
		subject.output.should_receive(:puts)
		subject.display_gameboard([1, 2, 3, 4, 5, 6, 7, 8, 9], 3)
	end
	
	it 'displays an invalid move message' do
		subject.output.should_receive(:puts).with("Invalid move.  Please try again.")
		subject.display_invalid_move
	end

	it 'displays a win message for a specific player' do
		subject.output.should_receive(:puts).with("Player 1 wins!")
		subject.display_win("Player 1")
	end

	it 'displays a draw message' do
		subject.output.should_receive(:puts).with("The game is a draw.")
		subject.display_draw
	end

	it 'prompts the player if they want to play again and receives their input' do
		subject.output.should_receive(:puts).with("Would you like to play again?")
		subject.input.should_receive(:gets).and_return("Y\n")
		subject.display_and_get_play_again
	end

	context "construct gameboard" do
		it "constructs a horizontal grid line" do
			subject.generate_grid_row(3).should == "\n-----+-----+-----"
		end

		it "constructs a gameboard margin" do
			subject.generate_margin(4).should == "     |     |     |     "
		end
	end

	context "#generate_row" do
		it "constructs a gameboard row with x, ' ' and x" do
			subject.generate_row(["x",2,"x"]) == "  x  |  2  |  x  "
		end

		it "constructs a gameboard row with x, o and x" do
			subject.generate_row(["x","o","x"]) == "  x  |  o  |  x  "
		end

		it "sets square1, square2 and square 3 to ' ' when nil" do
			subject.generate_row([1, 2, 3]) == "  1  |  2  |  3  \n"
		end

		it "constructs a empty gameboard" do
			subject.construct_gameboard([1, 2, 3, 4, 5, 6, 7, 8, 9], 3).should include("-----+-----+-----")
			subject.construct_gameboard([1, 2, 3, 4, 5, 6, 7, 8, 9], 3).should include("  1  |  2  |  3  ")
		end
	end

end