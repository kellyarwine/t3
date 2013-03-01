require 'spec_helper'

describe T3::Player do
  let(:gamepiece) { "x" }
  let(:subject) { T3::Player.new(gamepiece) }

  it 'has a piece' do
    T3::Player.new("x").piece.should == gamepiece
  end
  
end
