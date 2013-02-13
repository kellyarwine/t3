require 'spec_helper'

describe Board do
	it "has a length of 9" do
		described_class.new.spaces.should eq(Array.new(9))
	end

	context "#place_move" do
		it "allows a piece to be set" do
			subject.place_move("x",9)
			subject.spaces.should == [nil, nil, nil, nil, nil, nil, nil, nil,"x"]
		end

		it "allows a different piece to be set" do
			subject.place_move("x",9)
			subject.place_move("o",1)
			subject.spaces.should == ["o", nil, nil, nil, nil, nil, nil, nil,"x"]
		end
	end

  context "construct gameboard" do
		it "constructs a horizontal grid line" do
			subject.generate_horizontal_grid.should == "-----+-----+-----\n"
		end

		it "constructs a gameboard margin" do
			subject.generate_margin.should == "     |     |     \n"
		end
	end

	context "#generate_row" do
		it "constructs a gameboard row with x, ' ' and x" do
			subject.generate_row("x","","x") == "  x  |     |  x  "
		end

		it "constructs a gameboard row with x, o and x" do
			subject.generate_row("x","o","x") == "  x  |  o  |  x  "
		end

		it "sets square1, square2 and square 3 to ' ' when nil" do
			subject.generate_row("","","") == "     |     |     \n"
		end

		it "constructs a empty gameboard" do
			subject.spaces = ["","","","","","","","",""]
			subject.construct_gameboard.should include("-----+-----+-----")
			subject.construct_gameboard.should include("     |     |     ")
		end
	end

end