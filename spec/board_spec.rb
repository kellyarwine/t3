require 'spec_helper'

describe T3::Board do

  let(:subject) { T3::Board.new(3) }

  it "has a size" do
    subject.size.should == 3
  end

  it "has an array of spaces that are strings" do
    subject.spaces = ["1","2","3","4","5","6","7","8","9"]
  end

  it "returns the number of spaces in the row/column" do
    subject.size.should == 3
  end

  context "#place_move" do
    it "allows a piece to be set" do
      subject.place_move("x",9)
      subject.spaces.should == ["1","2","3","4","5","6","7","8","x"]
    end

    it "allows a piece to be set" do
      subject.place_move("x",9)
      subject.place_move("o",1)
      subject.spaces.should == ["o","2","3","4","5","6","7","8","x"]
    end
  end

  it "returns an array with all of the spaces (by string value) available for play" do
    subject.spaces = ["1","2","3","4","5","6","7","8","x"]
    subject.available_spaces_by_name.should == ["1","2","3","4","5","6","7","8"]
  end

  it "returns an array with all of the spaces (by index value) available for play" do
    subject.spaces = ["1","2","3","4","5","6","7","8","x"]
    subject.available_spaces_by_position.should == [0,1,2,3,4,5,6,7]
  end

  it "returns an array with all of the spaces available for play" do
    subject.spaces = ["x","o","x","o","x","o","7","8","x"]
    subject.available_spaces_by_position.should == [6,7]
  end

end
