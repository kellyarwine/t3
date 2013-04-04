require 'spec_helper'

describe T3::Player::EasyAi do

  let(:gamepiece)   { "x"                                       }
  let(:board)       { T3::Board.new(3)                          }
  let(:subject)	    { T3::Player::EasyAi.new(gamepiece) }

  it 'has a piece' do
    T3::Player::EasyAi.new("x").piece.should == gamepiece
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "should make a random move from the spaces available" do
    subject.move(board).should be_kind_of(Integer)
  end

end
