require 'spec_helper'

describe T3::Human do
  let(:console_io)	{ T3::ConsoleIo.new 						}
  let(:subject)			{ T3::Human.new("x",console_io) }

  it "should inherit from player" do
    described_class.ancestors.should include(T3::Player)
  end

  it "initializes the console_io, configurations and game" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
  end

  it "is a human" do
    subject.human? == true
  end	

  it 'has a piece' do
    subject.piece.should == "x"
  end

  it "should make a random move from the spaces available" do
    subject.console_io.should_receive(:get).and_return("2")
    subject.get_move(["2","3","4","5","6","7","8","9"]).should == 2
  end

end
