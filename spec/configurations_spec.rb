require 'spec_helper'

describe T3::Configurations do

  let(:console_io) { T3::ConsoleIo.new                                     }
  let(:board)      { T3::Board.new(3)                                      }
  let(:game_rules) { T3::GameRules.new(board)                              }
  let(:game_rules) { T3::GameRules.new(board)                              }
  let(:player_1)   { T3::Player::Human.new("x","o",game_rules,console_io)  }
  let(:player_2)   { T3::Player::EasyAi.new("x","o",game_rules,console_io) }
  let(:players)    { [player_1,player_2]                                   }
  let(:subject)	   { T3::Configurations.new(console_io)                    }

  it "instantiates the console_io and gamepieces" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
  end

  it "configures the game correctly" do
    subject.should_receive(:board).exactly(2).times
    subject.should_receive(:setup_players)
    subject.should_receive(:setup_turn_order)
    subject.configure_game
    subject.game_rules.should be_kind_of(T3::GameRules)
    subject.validations.should be_kind_of(T3::Validations)
    subject.player_builder.should be_kind_of(T3::Player::PlayerBuilder)
  end

  context "#board" do
    it "sets up a 3x3 board if one does not already exist" do
      subject.should_receive(:get_board_size).and_return(3)
      subject.board.should be_kind_of(T3::Board)
      subject.board.size.should == 3
    end

    it "returns the existing board if one already exists" do
      subject.board = board
      subject.board.should == board
    end
  end

  context "#board_size" do
    it "return 9 (the total number of squares on a 3x3 board)" do
      subject.console_io.should_receive(:display_board_size_prompt)
      subject.console_io.should_receive(:get).and_return("1")
      subject.board_size.should == 3
    end

    it "return 16 (the total number of squares on a 4x4 board)" do
      subject.console_io.should_receive(:display_board_size_prompt)
      subject.console_io.should_receive(:get).and_return("2")
      subject.board_size.should == 4
    end

    it "return 25 (the total number of squares on a 5x5 board)" do
      subject.console_io.should_receive(:display_board_size_prompt)
      subject.console_io.should_receive(:get).and_return("3")
      subject.board_size.should == 5
    end

    it "return 25 (the total number of squares on a 5x5 board) after an invalid selection is made" do
      subject.console_io.should_receive(:display_board_size_prompt).exactly(2).times
      subject.console_io.should_receive(:get).and_return("a","3")
      subject.console_io.should_receive(:display_invalid_selection)
      subject.board_size.should == 5
    end
  end

  xit "sets up players" do
    subject.player_builder.should_receive(:create).exactly(2).times
    subject.console_io.should_receive(:display_opponent_prompt)
    subject.console_io.should_receive(:get).and_return("1")
    subject.setup_players
  end

  context "#setup_turn_order" do
    it "returns an array of two players where player_1 is the first player and player_2 is the second player" do
      subject.console_io.should_receive(:display_turn_order_prompt)
      subject.console_io.should_receive(:get).and_return("1")
      subject.players = players
      subject.setup_turn_order.should == [player_1,player_2]
    end

    it "returns an array of two players where player_2 is the first player and player_1 is the second player" do
      subject.console_io.should_receive(:display_turn_order_prompt)
      subject.console_io.should_receive(:get).and_return("2")
      subject.players = players
      subject.setup_turn_order.should == [player_2,player_1]
    end

    it "returns an array of two players where player_2 is the first player and player_1 is the second player after 2 invalid selections" do
      subject.console_io.should_receive(:display_turn_order_prompt).exactly(3).times
      subject.console_io.should_receive(:get).and_return("100","a","2")
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.players = players
      subject.setup_turn_order.should == [player_2,player_1]
    end
  end

end
