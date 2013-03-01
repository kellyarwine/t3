require 'spec_helper'

describe T3::Configurations do

  let(:console_io) { T3::ConsoleIo.new                  }
  let(:board)      { T3::Board.new(9)                   }
  let(:player_1)   { T3::Human.new("x", console_io)     }
  let(:player_2)   { T3::EasyAi.new("o")                }
  let(:subject)	   { T3::Configurations.new(console_io) }

  it "instantiates the console_io and gamepieces" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
  end

  it "configures the game correctly" do
    subject.should_receive(:board)
    subject.should_receive(:setup_players)
    subject.should_receive(:setup_turn_order)
    subject.configure_game
    subject.game_rules.should be_kind_of(T3::GameRules)
  end

  context "#board" do
    it "sets up a 3x3 board if one does not already exist" do
      subject.should_receive(:get_board_size).and_return("9")
      subject.board.should be_kind_of(T3::Board)
      subject.board.size.should == "9"
    end	

    it "returns the existing board if one already exists" do
      subject.board = board
      subject.board.should == board
    end
  end

  context "#get_board_size" do
    it "return 9 (the total number of squares on a 3x3 board)" do
      subject.console_io.should_receive(:display_and_get_board).and_return("1")
      subject.get_board_size.should == 9
    end

    it "return 16 (the total number of squares on a 4x4 board)" do
      subject.console_io.should_receive(:display_and_get_board).and_return("2")
      subject.get_board_size.should == 16
    end

    it "return 25 (the total number of squares on a 5x5 board)" do
      subject.console_io.should_receive(:display_and_get_board).and_return("3")
      subject.get_board_size.should == 25
    end

    it "return 25 (the total number of squares on a 5x5 board) after an invalid selection is made" do
      subject.console_io.should_receive(:display_and_get_board).and_return("a","3")
      subject.console_io.should_receive(:display_invalid_selection)
      subject.get_board_size.should == 25
    end
  end

  context "#setup_players" do
    it "sets up player_1 as an AI player and player_2 as a human player" do
      subject.console_io.should_receive(:display_and_get_opponent).and_return("1")
      subject.console_io.should_receive(:display_and_get_gamepiece).and_return("o")
      subject.setup_players
      subject.player_1.should be_kind_of(T3::Human)
      subject.player_2.should be_kind_of(T3::EasyAi)
    end	

    it "sets up player_1 and player_2 as human players" do
      subject.console_io.should_receive(:display_and_get_opponent).and_return("2")
      subject.console_io.should_receive(:display_and_get_gamepiece).and_return("h","i")
      subject.setup_players
      subject.player_1.should be_kind_of(T3::Human)
      subject.player_2.should be_kind_of(T3::Human)
    end

    it "sets up player_1 and player_2 as human players after an invalid selection is made" do
      subject.console_io.should_receive(:display_and_get_opponent).and_return("4","2")
      subject.console_io.should_receive(:display_invalid_selection)
      subject.console_io.should_receive(:display_and_get_gamepiece).and_return("h","j")
      subject.setup_players
      subject.player_1.should be_kind_of(T3::Human)
      subject.player_2.should be_kind_of(T3::Human)
    end
  end

  context "#display_and_get_human_gamepiece" do
    it "returns a lowercase character as the gamepiece" do
      subject.console_io.should_receive(:display_and_get_gamepiece).and_return("A")
      subject.display_and_get_human_gamepiece.should == ("a")
    end

    it "returns a lowercase character as the gamepiece after an invalid selection is made" do
      subject.console_io.should_receive(:display_and_get_gamepiece).and_return("1","a")
      subject.console_io.should_receive(:display_invalid_selection)
      subject.should_receive(:store_gamepiece)
      subject.display_and_get_human_gamepiece.should == ("a")
    end
  end

  it "stores a gamepiece in the gamepieces array" do
    subject.store_gamepiece("x")
    subject.gamepieces.should == ["x"]
  end

  context "#gamepieces" do
    it "has a gamepieces array" do
      subject.gamepieces.should be_kind_of(Array)
    end

    it "creates a new gamepieces array if one does not already exist" do
      subject.gamepieces.should == []
    end

    it "returns the existing gamepieces array if one already exists" do
      subject.gamepieces = ["x"]
      subject.gamepieces.should == ["x"]
    end
  end

  context "#invalid_gamepiece?" do
    it "returns false when the gamepiece is valid" do
      subject.invalid_gamepiece?("j").should be_false
    end

    it "returns true when the gamepiece is invalid" do
      subject.invalid_gamepiece?("ab").should be_true
    end

    it "returns true when the gamepiece is invalid" do
      subject.invalid_gamepiece?("1").should be_true
    end

    it "returns true when the gamepiece is invalid" do
      subject.invalid_gamepiece?("40").should be_true
    end
  end

  context "#setup_turn_order" do
    it "returns [player_1,player_2]" do
      subject.console_io.should_receive(:display_and_get_turn_order).and_return("1")
      subject.setup_turn_order.should == [subject.player_1,subject.player_2]
    end

    it "returns [player_2,player_1]" do
      subject.console_io.should_receive(:display_and_get_turn_order).and_return("1")
      subject.setup_turn_order.should == [subject.player_2,subject.player_1]
    end

    it "returns [player_2,player_1] after 2 invalid selections" do
      subject.console_io.should_receive(:display_and_get_turn_order).and_return("100","a","2")
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.setup_turn_order.should == [subject.player_2,subject.player_1]
    end
  end

end
