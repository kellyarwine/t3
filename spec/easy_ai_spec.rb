require 'spec_helper'

describe T3::Player::EasyAi do
  let(:gamepiece) { "x"                         }
  let(:board)     { T3::Board.new(9)            }
  let(:subject)	  { T3::Player::EasyAi.new("x") }

  it 'has a piece' do
    T3::Player::EasyAi.new("x").piece.should == gamepiece
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "should make a random move from the spaces available" do
    subject.get_move(board).should be_kind_of(Integer)
  end

end
