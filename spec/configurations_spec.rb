require 'spec_helper'

describe T3::Configurations do

  before {
    subject.validations = validations
    subject.players = players
  }

  let(:board)       { T3::Board.new(3)                                                              }
  let(:game_rules)  { T3::GameRules.new(board)                                                      }
  let(:validations) { T3::Validations.new                                                           }
  let(:prompter)    { T3::Prompter.new                                                              }
  let(:player_1)    { T3::Player::PlayerContext.new(T3::Player::HumanStrategy.new("x",prompter))    }
  let(:player_2)    { T3::Player::PlayerContext.new(T3::Player::EasyAiStrategy.new("o"))            }
  let(:players)     { [player_1,player_2]                                                           }
  let(:subject)	    { T3::Configurations.new(prompter)                                              }

  it "has a prompter" do
    subject.prompter.should be_kind_of(T3::Prompter)
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
    subject.prompter.should_receive(:board_size).and_return(3)
    subject.build_board
    subject.board.should be_kind_of(T3::Board)
    subject.board.size.should == 3
  end

  it "sets up two players" do
    subject.prompter.should_receive(:human_gamepiece).and_return("r")
    subject.should_receive(:opponent).and_return(T3::Player::EasyAiStrategy.new("x"))
    subject.setup_players
    subject.player_1.should be_kind_of(T3::Player::PlayerContext)
    subject.player_2.should be_kind_of(T3::Player::PlayerContext)
    subject.player_1.strategy.should be_kind_of(T3::Player::HumanStrategy)
    subject.player_2.strategy.should be_kind_of(T3::Player::EasyAiStrategy)
  end

  context "#opponent" do
    it "should prompt the user for an opponent and return a human opponent" do
      subject.prompter.should_receive(:opponent).and_return("3")
      subject.prompter.should_receive(:human_gamepiece).and_return("r")
      subject.opponent.should be_kind_of(T3::Player::HumanStrategy)
    end

    it "should prompt the user for an opponent and return an easy ai opponent" do
      subject.prompter.should_receive(:opponent).and_return("1")
      subject.opponent.should be_kind_of(T3::Player::EasyAiStrategy)
    end

    it "should prompt the user for an opponent and return an hard ai opponent" do
      subject.prompter.should_receive(:opponent).and_return("2")
      subject.opponent.should be_kind_of(T3::Player::MinimaxStrategy)
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
      subject.prompter.should_receive(:turn_order).and_return("1")
      subject.setup_turn_order.should == [player_1,player_2]
    end

    it "returns an array of two players where player_2 is the first player and player_1 is the second player" do
      subject.prompter.should_receive(:turn_order).and_return("2")
      subject.setup_turn_order.should == [player_2,player_1]
    end
  end

end
