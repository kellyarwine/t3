require 'spec_helper'

describe T3::Player::EasyAi do

  let(:gamepiece)   { "x"                                                         }
  let(:gamepieces)  { ["x","o"]                                                   }
  let(:board)       { T3::Board.new(3)                                            }
  let(:game_rules)  { T3::GameRules.new(board)                                    }
  let(:console_io)  { T3::ConsoleIo.new                                           }
  let(:subject)	    { T3::Player::EasyAi.new(gamepiece,"o",game_rules,console_io) }

  it 'has a piece' do
    T3::Player::EasyAi.new(gamepiece,"o",game_rules,console_io).piece.should == "o"
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "should make a random move from the spaces available" do
    subject.get_move(board,gamepieces).should be_kind_of(Integer)
  end

end
