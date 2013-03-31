require 'spec_helper'

describe T3::Player::HumanStrategy do

  let(:gamepiece)   { "x"                                                 }
  let(:board)       { T3::Board.new(3)                                    }
  let(:prompter)    { T3::Prompter.new                                    }
  let(:subject)     { T3::Player::HumanStrategy.new(gamepiece,prompter)   }

  it 'has a piece' do
    T3::Player::HumanStrategy.new("x",prompter).piece.should == gamepiece
  end

  it "initializes the io" do
    subject.prompter.should be_kind_of(T3::Prompter)
  end

  it "is a human" do
    subject.human? == true
  end

  it 'has a piece' do
    subject.piece.should == "x"
  end

  it "should prompt for a move" do
    subject.prompter.should_receive(:human_move).and_return(2)
    subject.move.should == 2
  end

end
