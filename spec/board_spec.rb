require 'spec_helper'

describe Board do

	let(:subject)			{ Board.new(16) }
	
	it "has a length of 16 and all elements are strings" do
		subject.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
	end

	it "has no elements that are integers" do
		subject.should_not == [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
	end

	it "returns the size of the board" do
		subject.size.should == 16
	end

	it "returns the number of spaces in the row/column" do
		subject.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
		subject.row_column_size.should == 4
	end

	context "#place_move" do
		it "allows a piece to be set" do
			subject.place_move("x",9)
			subject.spaces.should == ["1","2","3","4","5","6","7","8","x","10","11","12","13","14","15","16"]
		end

		it "allows a different piece to be set" do
			subject.place_move("x",9)
			subject.place_move("o",1)
			subject.spaces.should == ["o","2","3","4","5","6","7","8","x","10","11","12","13","14","15","16"]
		end
	end

	it "returns an array with all of the spaces available for play" do
		subject.spaces = ["1","2","3","4","5","6","7","8","x","10","11","12","13","14","15","16"]
		subject.available_spaces.should == ["1","2","3","4","5","6","7","8","10","11","12","13","14","15","16"]
	end

end