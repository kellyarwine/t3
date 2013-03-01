require 'spec_helper'

describe Human do
  let(:console_io)	{ ConsoleIo.new 						}
  let(:subject)			{ Human.new("x",console_io) }

  it "should inherit from player" do
    described_class.ancestors.should include(Player)
  end

  it "initializes the console_io, configurations and game" do
    subject.console_io.should be_kind_of(ConsoleIo)
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