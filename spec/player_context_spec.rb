require 'spec_helper'

describe T3::Player::PlayerContext do

  let(:player_strategy) { T3::Player::EasyAiStrategy.new("x")            }
  let(:board)           { T3::Board.new(3)                               }
  let(:subject)         { T3::Player::PlayerContext.new(player_strategy) }

  it "initializes a strategy" do
    subject.strategy.should == player_strategy
  end

  it "has a piece" do
    subject.piece.should == "x"
  end

  it "is not a human" do
    subject.human?.should == false
  end

  it "should return a move" do
    subject.move(board,["x","o"]).should be_kind_of(Integer)
  end

end
