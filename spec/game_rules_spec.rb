require 'spec_helper'

describe GameRules do
	let(:board) 				{ Board.new }
	let(:subject) 			{ GameRules.new(board) }
	
	context "#invalid_move?" do
		it "returns false when input is a 0" do
			subject.invalid_move?(0).should == true
		end

		it "returns false when input is greater than board size" do
			subject.invalid_move?(10).should == true
		end

		it "returns false when a square is occupied" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.invalid_move?(6).should == true
		end

		it "returns true when a square is not occupied and integer is valid" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.invalid_move?(8).should == false
		end
	end

	context "#input_valid_integer?" do
		it "returns true when input is a value between 1 and 9" do
			subject.input_valid_integer?(9).should == true
		end

		it "returns true when input is a value between 1 and 9" do
			subject.input_valid_integer?(1).should == true
		end

		it "returns true when input is a value between 1 and 9" do
			subject.input_valid_integer?(+9).should == true
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?(0).should == false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?(-1).should == false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?(10).should == false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("hello").should == false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("a").should == false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("\n").should == false
		end

		it "returns false when input is a value not between 1 and 9" do
			subject.input_valid_integer?("").should == false
		end
	end

	context "#space_open?" do
		it "returns true when a square is not occupied" do
			subject.board.spaces = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
			subject.space_open?(9).should == true
		end

		it "returns false when a square is not occupied" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.space_open?(6).should == false
		end
	end

	context "#game_over?" do
		it "returns true when game is over" do
			subject.board.spaces = ["x","x","o","o","x","o","x","o","x"]
			subject.game_over?.should == true
		end

		it "returns false when game is not over" do
			subject.board.spaces = ["x",nil,"o","o","x","o","x","o","x"]
			subject.game_over?.should == false
		end		
	end

	it "returns true when a game is won" do
		subject.game_win? == true
	end



end	