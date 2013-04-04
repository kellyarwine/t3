require 'spec_helper'

describe Console::Prompter do

  let(:io)          { Console::Io.new                           }
  let(:board)       { T3::Board.new(4)                          }
  let(:validations) { T3::Validations.new                       }
  let(:game_rules)  { T3::GameRules.new(board)                  }
  let(:player_1)    { T3::Player::Human.new("x")                }
  let(:player_2)    { T3::Player::EasyAi.new("o")               }
  let(:player_3)    { T3::Player::Minimax.new("o", game_rules)  }
  let(:players)     { [player_1,player_2]                       }
  let(:subject)     { Console::Prompter.new(io)                 }

  context "#board_size" do
    it "returns the board size" do
      subject.io.should_receive(:display).exactly(4).times
      subject.io.should_receive(:get).and_return("2")
      subject.board_size.should == 4
    end

    it "returns the board size after two invalid selections are made" do
      subject.io.should_receive(:display).exactly(12).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:get).and_return("a","6","1")
      subject.board_size.should == 3
    end

    it "returns the board size after three invalid selections are made" do
      subject.io.should_receive(:display).exactly(16).times
      subject.io.should_receive(:display_invalid_selection).exactly(3).times
      subject.io.should_receive(:get).and_return("a","6","","3")
      subject.board_size.should == 5
    end
  end

  context "#opponent" do
    it "returns a Hard AI opponent with a gamepiece of x" do
      subject.io.should_receive(:display).exactly(4).times
      subject.io.should_receive(:get).and_return("2")
      subject.opponent.should == "2"
    end

    it "returns an Easy AI opponent after two invalid selections are made" do
      subject.io.should_receive(:display).exactly(12).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:get).and_return("a","6","1")
      subject.opponent.should == "1"
    end

    it "returns an Human opponent after three invalid selections are made" do
      subject.io.should_receive(:display).exactly(16).times
      subject.io.should_receive(:display_invalid_selection).exactly(3).times
      subject.io.should_receive(:get).and_return("a","6",".","3")
      subject.opponent.should == "3"
    end
  end

  context "#human_gamepiece" do
    it "returns a gamepiece of a" do
      subject.io.should_receive(:display).exactly(1).times
      subject.validations.should_receive(:store_gamepiece).exactly(1).times
      subject.io.should_receive(:get).and_return("a")
      subject.human_gamepiece.should == "a"
    end

    it "returns a gamepiece of a (lowercase)" do
      subject.io.should_receive(:display).exactly(1).times
      subject.validations.should_receive(:store_gamepiece).exactly(1).times
      subject.io.should_receive(:get).and_return("A")
      subject.human_gamepiece.should == "a"
    end

    it "returns a gamepiece of x after two invalid selections are made" do
      subject.io.should_receive(:display).exactly(3).times
      subject.validations.should_receive(:store_gamepiece).exactly(1).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:get).and_return("","6","x")
      subject.human_gamepiece.should == "x"
    end
  end

  context "#opponent_gamepiece" do
    it "prompts for a human gamepiece when the opponent is a human" do
      subject.io.should_receive(:display)
      subject.io.should_receive(:get).and_return("r")
      subject.opponent_gamepiece(player_1) == "r"
    end

    it "returns an ai gamepiece when the opponent is a easy ai player" do
      subject.opponent_gamepiece(player_2).should == "x"
    end

    it "returns an ai gamepiece when the opponent is a hard ai player" do
      subject.opponent_gamepiece(player_3).should == "x"
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

  context "#turn_order" do
    it "returns a turn order selection where player_1 will go first" do
      subject.io.should_receive(:display).exactly(3).times
      subject.io.should_receive(:get).and_return("1")
      subject.turn_order.should == "1"
    end

    it "returns a turn order selection where player_2 will go first after two invalid selections are made" do
      subject.io.should_receive(:display).exactly(9).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:get).and_return(".","3","2")
      subject.turn_order.should == "2"
    end
  end

  context "#human_move" do
    it "returns a human move selection that is valid" do
      board.spaces = ["o","x","o","o","x","o","7","8","x"]
      subject.io.should_receive(:display).exactly(1).times
      subject.io.should_receive(:get).and_return("8")
      subject.human_move(board).should == 8
    end

  it "returns a human move selection that is valid after two invalid selections are made" do
      board.spaces = ["o","x","o","o","x","o","7","8","x"]
      subject.io.should_receive(:display).exactly(3).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:get).and_return("9","","7")
      subject.human_move(board).should == 7
    end
  end

  context "#play_again?" do
    it "returns a turn order selection where player_1 will go first" do
      subject.io.should_receive(:display).exactly(1).times
      subject.io.should_receive(:get).and_return("y")
      subject.play_again? .should == true
    end

    it "returns a turn order selection where player_2 will go first after two invalid selections are made" do
      subject.io.should_receive(:display).exactly(3).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:get).and_return(".","3","n")
      subject.play_again?.should == false
    end
  end

end