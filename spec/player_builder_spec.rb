require 'spec_helper'

describe T3::Player::PlayerBuilder do

  let(:console_io)  { T3::ConsoleIo.new                                     }
  let(:validations) { T3::Validations.new(board)                            }
  let(:board)       { T3::Board.new(3)                                      }
  let(:game_rules)  { T3::GameRules.new(board)                              }
  let(:subject)     { T3::Player::PlayerBuilder.new(console_io,validations) }

  it "initializes a console_io" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
  end

  context "#create" do
    it "should create an easy ai player" do
      subject.should_receive(:human_gamepiece).and_return("r")
      subject.create("1",game_rules).should be_kind_of(T3::Player::EasyAi)
    end

    it "should create an hard ai player" do
      subject.should_receive(:human_gamepiece).and_return("r")
      subject.create("2",game_rules).should be_kind_of(T3::Player::Minimax)
    end

    it "should create an human player" do
      subject.should_receive(:human_gamepiece).and_return("r")
      subject.create("3",game_rules).should be_kind_of(T3::Player::Human)
    end

    xit "sets up player_1 and player_2 as human players after an invalid selection is made" do
      subject.should_receive(:human_gamepiece).and_return("r")
      subject.should_receive(:invalid_something)
      subject.create("4","3",game_rules).should be_kind_of(T3::Player::Human)
    end
  end

  context "#gamepiece" do
    it "prompts for a gamepiece when player is human" do
      subject.should_receive(:human_gamepiece)
      subject.gamepiece("3")
    end

    it "prompts for a gamepiece when player is human and a human gamepiece does exist" do
      subject.should_receive(:human_gamepiece)
      subject.gamepiece("1")
    end

    it "prompts for a gamepiece when player is the ai and a human gamepiece does not exist" do
      subject.should_receive(:human_gamepiece)
      subject.gamepiece("1")
    end

    it "does not prompt for a gamepiece when player is the ai and a human gamepiece does exist" do
      subject.gamepiece = "r"
      subject.should_not_receive(:human_gamepiece)
      subject.gamepiece("1")
    end
  end

  context "#human_gamepiece" do
    it "returns a gamepiece for the human player" do
      subject.console_io.should_receive(:display_gamepiece_prompt)
      subject.console_io.should_receive(:get).and_return("r")
      subject.validations.should_receive(:invalid_gamepiece?).and_return(false)
      subject.human_gamepiece.should == "r"
    end

   it "returns a lowercase gamepiece for the human player after two invalid gamepieces" do
      subject.console_io.should_receive(:display_gamepiece_prompt)
      subject.console_io.should_receive(:get).and_return("rr","3","R")
      subject.validations.should_receive(:invalid_gamepiece?).and_return(true,true,false)
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.validations.should_receive(:store_gamepiece)
      subject.human_gamepiece.should == "r"
    end
  end

end
