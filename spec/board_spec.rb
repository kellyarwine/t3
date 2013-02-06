require 'Board'

describe Board do
	it "has a length of 9" do
		described_class.new.spaces.should eq(Array.new(9))
	end

	it "allows a piece to be set" do
		subject.place_move("x",9) == ["","","","","","","","","x"]
	end

	it "constructs a horizontal grid line" do
		subject.generate_gameboard_horizontal_grid == "-----+-----+-----"
	end

	it "constructs a gameboard margin" do
		subject.generate_gameboard_horizontal_grid == "     |     |     "
	end

	describe "#generate_gameboard_row" do
		it "constructs a gameboard row with x, ' ' and x" do
			subject.generate_gameboard_row("x","","x") == "  x  |     |  x  "
		end

		it "constructs a gameboard row with x, o and x" do
			subject.generate_gameboard_row("x","o","x") == "  x  |  o  |  x  "
		end

		it "sets square1, square2 and square 3 to ' ' when nil" do
			subject.generate_gameboard_row("","","") == "     |     |     \n"
		end
	end

	it "constructs a empty gameboard" do
		subject.spaces = ["","","","","","","","",""]
		subject.construct_gameboard.should include("-----+-----+-----")
		subject.construct_gameboard.should include("     |     |     ")
	end
end