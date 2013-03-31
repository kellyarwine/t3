require 'spec_helper'

describe T3::Io do

  let(:player_1)  { double(:EasyAIStrategy, human?: false, piece: "x") }
  let(:player_2)  { double(:HumanStrategy, human?: true, piece: "o")   }

  it "has an input and output" do
    subject.input.should be_kind_of(IO)
    subject.output.should be_kind_of(IO)
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

  it "displays an invalid selection message" do
    subject.player_label(player_1).should == "Computer"
    subject.player_label(player_2).should == "Human"
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