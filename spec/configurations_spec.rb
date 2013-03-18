require 'spec_helper'

describe T3::Configurations do

  before {
    subject.validations = validations
    subject.players = players
  }

  let(:console_io)  { T3::ConsoleIo.new                                                             }
  let(:board)       { T3::Board.new(3)                                                              }
  let(:game_rules)  { T3::GameRules.new(board)                                                      }
  let(:validations) { T3::Validations.new(board)                                                    }
  let(:player_1)    { T3::Player::PlayerContext.new(T3::Player::HumanStrategy.new("x",console_io))  }
  let(:player_2)    { T3::Player::PlayerContext.new(T3::Player::EasyAiStrategy.new("o"))            }
  let(:players)     { [player_1,player_2]                                                           }
  let(:subject)	    { T3::Configurations.new(console_io)                                            }

  it "has a console_io" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
  end

  it "configures the game correctly" do
    subject.should_receive(:build_board).exactly(1).times
    subject.should_receive(:setup_players)
    subject.should_receive(:setup_turn_order)
    subject.configure_game
    subject.game_rules.should be_kind_of(T3::GameRules)
    subject.validations.should be_kind_of(T3::Validations)
  end

  it "builds the board" do
    subject.console_io.should_receive(:display_board_size_prompt).with([3,4,5])
    subject.console_io.should_receive(:get).and_return("1")
    subject.build_board
    subject.board.should be_kind_of(T3::Board)
  end

  context "#board_size" do
    it "return 3 (the total number of squares on a 3x3 board)" do
      subject.console_io.should_receive(:display_board_size_prompt).with([3,4,5])
      subject.console_io.should_receive(:get).and_return("1")
      subject.board_size.should == 3
    end

    it "return 4 (the total number of squares on a 4x4 board)" do
      subject.console_io.should_receive(:display_board_size_prompt).with([3,4,5])
      subject.console_io.should_receive(:get).and_return("2")
      subject.board_size.should == 4
    end

    it "return 5 (the total number of squares on a 5x5 board)" do
      subject.console_io.should_receive(:display_board_size_prompt).with([3,4,5])
      subject.console_io.should_receive(:get).and_return("3")
      subject.board_size.should == 5
    end

    it "return 5 (the total number of squares on a 5x5 board) after an invalid selection is made" do
      subject.console_io.should_receive(:display_board_size_prompt).exactly(2).times
      subject.console_io.should_receive(:get).and_return("a","3")
      subject.console_io.should_receive(:display_invalid_selection)
      subject.board_size.should == 5
    end
  end

  it "sets up two players" do
    subject.should_receive(:human_gamepiece).and_return("r")
    subject.should_receive(:opponent).and_return(T3::Player::EasyAiStrategy.new("x"))
    subject.setup_players
    subject.player_1.should be_kind_of(T3::Player::PlayerContext)
    subject.player_2.should be_kind_of(T3::Player::PlayerContext)
    subject.player_1.strategy.should be_kind_of(T3::Player::HumanStrategy)
    subject.player_2.strategy.should be_kind_of(T3::Player::EasyAiStrategy)
  end

  it "should prompt the user for an opponent" do
    subject.console_io.should_receive(:display_opponent_prompt)
    subject.should_receive(:get_opponent)
    subject.opponent
  end

  context "#get_opponent" do
    it "should return an easy_ai opponent" do
      subject.console_io.should_receive(:get).and_return("1")
      subject.get_opponent.should be_kind_of(T3::Player::EasyAiStrategy)
    end

    it "should return a Minimax opponent" do
      subject.console_io.should_receive(:get).and_return("2")
      subject.get_opponent.should be_kind_of(T3::Player::MinimaxStrategy)
    end

    it "should return a Human opponent" do
      subject.console_io.should_receive(:get).and_return("3")
      subject.should_receive(:human_gamepiece).and_return("r")
      subject.get_opponent.should be_kind_of(T3::Player::HumanStrategy)
    end

    it "should return a Human opponent after two invalid selections are made" do
      subject.console_io.should_receive(:get).and_return("4","100","3")
      subject.should_receive(:human_gamepiece).and_return("r")
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.console_io.should_receive(:display_opponent_prompt).exactly(2).times
      subject.get_opponent.should be_kind_of(T3::Player::HumanStrategy)
    end
  end

  it "returns a gamepiece for the human player" do
    subject.console_io.should_receive(:display_gamepiece_prompt)
    subject.should_receive(:get_human_gamepiece)
    subject.human_gamepiece
  end

  context "#get_human_gamepiece" do
    it "returns a gamepiece for the human player" do
      subject.console_io.should_receive(:get).and_return("y")
      # subject.validations.should_receive(:invalid_gamepiece?).and_return(false)
      subject.validations.should_receive(:store_gamepiece)
      subject.get_human_gamepiece.should == "y"
    end

    it "returns a lowercase gamepiece for the human player when an uppercase letter is entered" do
      subject.console_io.should_receive(:get).and_return("Y")
      # subject.validations.should_receive(:invalid_gamepiece?).and_return(false)
      subject.validations.should_receive(:store_gamepiece)
      subject.get_human_gamepiece.should == "y"
    end

    it "returns a gamepiece for the human player after two invalid selections are made" do
      subject.console_io.should_receive(:get).and_return("ra","1","y")
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.console_io.should_receive(:display_gamepiece_prompt).exactly(2).times
      subject.validations.should_receive(:store_gamepiece).exactly(1).times
      subject.get_human_gamepiece.should == "y"
    end
  end

  context "#ai_gamepiece" do
    it "returns a gamepiece for ai player" do
      subject.validations.gamepieces = []
      subject.ai_gamepiece.should == "x"
    end

    it "returns a gamepiece for ais human player" do
      subject.validations.gamepieces = ["x"]
      subject.ai_gamepiece.should == "o"
    end
  end

  context "#setup_turn_order" do
    it "returns an array of two players where player_1 is the first player and player_2 is the second player" do
      subject.console_io.should_receive(:display_turn_order_prompt)
      subject.console_io.should_receive(:get).and_return("1")
      subject.setup_turn_order.should == [player_1,player_2]
    end

    it "returns an array of two players where player_2 is the first player and player_1 is the second player" do
      subject.console_io.should_receive(:display_turn_order_prompt)
      subject.console_io.should_receive(:get).and_return("2")
      subject.setup_turn_order.should == [player_2,player_1]
    end

    it "returns an array of two players where player_2 is the first player and player_1 is the second player after 2 invalid selections" do
      subject.console_io.should_receive(:display_turn_order_prompt).exactly(3).times
      subject.console_io.should_receive(:get).and_return("100","a","2")
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.setup_turn_order.should == [player_2,player_1]
    end
  end

end
