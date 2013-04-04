require 'spec_helper'

describe T3::Player::Human do

  let(:gamepiece) { "x"                               }
  let(:board)     { T3::Board.new(3)                  }
  let(:subject)   { T3::Player::Human.new(gamepiece)  }

  it 'has a piece' do
    T3::Player::Human.new("x").piece.should == gamepiece
  end

  it "is a human" do
    subject.human? == true
  end

end
