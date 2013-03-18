require 'spec_helper'

describe T3::Player::HumanStrategy do

  let(:gamepiece)   { "x"                                                 }
  let(:board)       { T3::Board.new(3)                                    }
  let(:console_io)  { T3::ConsoleIo.new                                   }
  let(:subject)     { T3::Player::HumanStrategy.new(gamepiece,console_io) }

  it 'has a piece' do
    T3::Player::HumanStrategy.new("x",@console_io).piece.should == gamepiece
  end

  it "initializes the console_io" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
  end

  it "is a human" do
    subject.human? == true
  end

  it 'has a piece' do
    subject.piece.should == "x"
  end

  it "should prompt for a move" do
    subject.console_io.should_receive(:get).and_return("2")
    subject.move(board,["x","o"]).should == 2
  end

end
