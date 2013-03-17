require 'spec_helper'

describe T3::ConsoleIo do
  before {
    subject.input = StringIO.new
    subject.output = StringIO.new
  }

  let(:console_io) { ConsoleIo.new }
  let(:player_1)   { double(:EasyAI, human?: false, piece: "x") }
  let(:player_2)   { double(:Human, human?: true) }

  it "initializes the input and output" do
    subject.input.should be_kind_of(StringIO)
    subject.output.should be_kind_of(StringIO)
  end

  it "displays a message" do
  	subject.output.should_receive(:puts)
  	subject.display("Hi")
  end

  it "returns input" do
    subject.input.should_receive(:gets).and_return("9\n")
    subject.get
  end

  it "displays an invalid selection message" do
    subject.output.should_receive(:puts).with("Invalid selection.  Please try again.")
    subject.display_invalid_selection
  end

  it "prompts the player for their choice of opponent" do
    subject.output.should_receive(:puts).with("Choose your opponent:\n\n")
    subject.output.should_receive(:puts).with("1. Easy AI\n")
    subject.output.should_receive(:puts).with("2. Hard AI\n")
    subject.output.should_receive(:puts).with("3. Human\n")
    subject.display_opponent_prompt
  end

  it "prompts the player for their board choice and receives their input" do
    subject.output.should_receive(:puts).with("Choose the board size:\n\n")
    subject.output.should_receive(:puts).with("1. 3x3\n")
    subject.output.should_receive(:puts).with("2. 4x4\n")
    subject.output.should_receive(:puts).with("3. 5x5\n")
    subject.display_board_size_prompt(["3","4","5"])
  end


  it "prompts the player for their gamepiece choice and receives their input" do
    subject.output.should_receive(:puts).with("Choose any letter to be the gamepiece.")
    subject.display_gamepiece_prompt
  end

  it "prompts the player for the turn order" do
    subject.output.should_receive(:puts).with("Choose which player goes first:\n\n")
    subject.output.should_receive(:puts).with("1. Computer\n")
    subject.output.should_receive(:puts).with("2. Human\n")
    subject.display_turn_order_prompt([player_1,player_2])
  end

  it "displays a welcome message" do
    subject.output.should_receive(:puts).with("\nWelome to T3!  Get ready to lose.\n\n")
    subject.display_welcome_message
  end

  it "displays a gameboard" do
    spaces = ["1","2","3","4","5","6","7","8","9"]
    size = 3
    subject.output.should_receive(:puts)
    subject.display_gameboard(spaces,size)
  end

  context "#construct gameboard" do
    it "displays an empty gameboard" do
      spaces = ["1","2","3","4","5","6","7","8","9"]
      row_column_size = 3
      subject.construct_gameboard(spaces, row_column_size).should include("     |     |     ")
      subject.construct_gameboard(spaces, row_column_size).should include("  1  |  2  |  3  ")
      subject.construct_gameboard(spaces, row_column_size).should include("-----+-----+-----")
      subject.construct_gameboard(spaces, row_column_size).should include("  4  |  5  |  6  ")			
      subject.construct_gameboard(spaces, row_column_size).should include("  7  |  8  |  9  ")
    end

    it "displays a full gameboard" do
      spaces = ["x","o","x","o","x","o","x","o","o"]
      row_column_size = 3
      subject.construct_gameboard(spaces, row_column_size).should include("     |     |     ")
      subject.construct_gameboard(spaces, row_column_size).should include("  x  |  o  |  x  ")
      subject.construct_gameboard(spaces, row_column_size).should include("-----+-----+-----")
      subject.construct_gameboard(spaces, row_column_size).should include("  o  |  x  |  o  ")			
      subject.construct_gameboard(spaces, row_column_size).should include("  x  |  o  |  o  ")
    end
  end

  it "prompts player 1 for a move" do
    subject.output.should_receive(:puts).with("Computer, please enter a move (1-9):")
    subject.display_request_for_move(player_1)
  end

  it "displays a win message for a specific player" do
    subject.output.should_receive(:puts).with("x wins!")
    subject.display_win(player_1.piece)
  end

  it "displays a draw message" do
    subject.output.should_receive(:puts).with("The game is a draw.")
    subject.display_draw
  end

  it "prompts the player if they want to play again and receives their input" do
    subject.output.should_receive(:puts).with("Would you like to play again?")
    subject.display_play_again_prompt
  end

end
