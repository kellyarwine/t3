require 'spec_helper'

describe T3::Player::EasyAi do
  let(:gamepiece) { "x" }
  let(:subject)	{ T3::Player::EasyAi.new("x") }

  it 'has a piece' do
    T3::Player::EasyAi.new("x").piece.should == gamepiece
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "should make a random move from the spaces available" do
    subject.get_move(["2","3","4","5","6","7","8","9"]).should be_kind_of(Integer)
  end

end
