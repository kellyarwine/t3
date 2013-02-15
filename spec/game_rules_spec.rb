require 'spec_helper'

describe GameRules do
	let(:board) 				{ Board.new }
	let(:subject) 			{ GameRules.new(board) }
	
	context "#invalid_move?" do
		it "returns false when input is a 0" do
			subject.invalid_move?(0).should be_true
		end

		it "returns false when input is greater than board size" do
			subject.invalid_move?(10).should be_true
		end

		it "returns false when a square is occupied" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.invalid_move?(6).should be_true
		end

		it "returns true when a square is not occupied and integer is valid" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.invalid_move?(8).should be_false
		end
	end

	context "#input_valid_integer?" do
		it "returns true when input is a value between 1 and 9" do
			subject.input_valid_integer?(9).should be_true
		end

		it "returns true when input is a value between 1 and 9" do
			subject.input_valid_integer?(1).should be_true
		end

		it "returns true when input is a value between 1 and 9" do
			subject.input_valid_integer?(+9).should be_true
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?(0).should be_false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?(-1).should be_false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?(10).should be_false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("hello").should be_false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("a").should be_false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("\n").should be_false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("").should be_false
		end
	end

	context "#space_open?" do
		it "returns true when a square is not occupied" do
			subject.board.spaces = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
			subject.space_open?(9).should be_true
		end

		it "returns false when a square is not occupied" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.space_open?(6).should be_false
		end
	end

	context "#game_over?" do
		it "returns true when board is full and there are no wins" do
			subject.board.spaces = ["x","x","o","o","x","x","x","o","o"]
			subject.game_over?.should be_true
		end

		it "returns false when board is not full and there are no wins" do
			subject.board.spaces = ["x",nil,"o","o","x","x","x","o","o"]
			subject.game_over?.should be_false
		end

		it "returns true when board is not full and there are wins" do
			subject.board.spaces = ["x",nil,"o","o","x","o","o","o","x"]
			subject.game_over?.should be_true
		end		

		it "returns true when board is full and there are wins" do
			subject.board.spaces = ["x",nil,"o","o","x","o","x","o","x"]
			subject.game_over?.should be_true
		end		
	end

	context "#game_win" do
		it "returns x when there are 3 x's in a row" do
			board.spaces = ["x","x","x",nil,nil,nil,nil,nil,nil]
			subject.game_win.should == "x"
		end

		it "returns x when there are 3 x's in a column" do
			board.spaces = ["x",nil,nil,"x",nil,nil,"x",nil,nil]
			subject.game_win.should == "x"
		end

		it "returns o when the left diagonal has 3 o's" do
			board.spaces = ["o",nil,nil,nil,"o",nil,nil,nil,"o"]
			subject.game_win.should == "o"
		end

		it "returns o when the right diagonal has 3 o's" do
			board.spaces = [nil,nil,"o",nil,"o",nil,"o",nil,nil]
			subject.game_win.should == "o"
		end

		it "returns false when a game is not won" do
			board.spaces = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
			subject.game_win.should == ""
		end

		it "returns false when a game is a draw" do
			board.spaces = ["x","o","x","o","x","o","o","x","o"]
			subject.game_win.should == ""
		end				
	end

	it "returns an array of 3 arrays with the values from each row contained in one array" do
		board.spaces = ["x","o","x","o","x","o","x","o","x"]
		subject.row_contents.should == [["x","o","x"],["o","x","o"],["x","o","x"]]
	end

	it "returns an array of 3 arrays with the values from each column contained in one array" do
		board.spaces = ["x","x","x","o","x","o","x","x","x"]
		subject.column_contents.should == [["x","o","x"],["x","x","x"],["x","o","x"]]
	end	

	it "returns an array of 1 array with the values from the left diagonal" do
		board.spaces = ["x","x","o","o","o","o","x","x","o"]
		subject.left_diagonal_contents.should == [["x","o","o"]]
	end

	it "returns an array of 1 array with the values from the right diagonal" do
		board.spaces = ["x","x","o","o","o","o","x","x","o"]
		subject.right_diagonal_contents.should == [["o","o","x"]]
	end

	it "returns an array of 1 array with the values from the left diagonal" do
		board.spaces = ["x","o","x","x","o","x","x","o","x"]
		subject.left_diagonal_contents.should == [["x","o","x"]]
	end

	it "returns an array of 1 array with the values from the right diagonal" do
		board.spaces = ["x","x","o","x","x","o","x","x","o"]
		subject.right_diagonal_contents.should == [["o","x","x"]]
	end

end	