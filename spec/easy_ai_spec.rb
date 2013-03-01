require 'spec_helper'

describe EasyAi do

  let(:subject)	{ EasyAi.new("x") }

  it "should inherit from player" do
    described_class.ancestors.should include(Player)
  end

  it 'has a piece' do
    subject.piece.should == "x"
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "should make a random move from the spaces available" do
    subject.get_move(["2","3","4","5","6","7","8","9"]).should be_kind_of(Integer)
  end

end