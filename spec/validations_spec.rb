require 'validations'

describe Validations do
	let(:board) 				{ Board.new 							}
	let(:console_io) 		{ ConsoleIo.new(board)		}
	let(:subject) 			{ Validations.new(board)	}
	
	context "#invalid_move?" do
		it "returns true when input is a 0" do
			subject.invalid_move?(0).should be_true
		end

		it "returns true when input is greater than board size" do
			subject.invalid_move?(10).should be_true
		end

		it "returns true when a square is occupied" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.invalid_move?(6).should be_true
		end

		it "returns false when a square is not occupied and integer is valid" do
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

		it "returns false when a square is occupied" do
			subject.board.spaces = ["x",nil,nil,"o",nil,"o","x",nil,nil]
			subject.space_open?(6).should be_false
		end
	end

	context "#one_character?" do
		it "returns true when gamepiece is one character" do
			subject.one_character?("a").should be_true
		end

		it "returns false when gamepiece is more than one character" do
			subject.one_character?("ab").should be_false
		end

		it "returns false when gamepiece is more than one character" do
			subject.one_character?("ppp").should be_false
		end	
	end

	context "#duplicate_gamepiece?" do
		it "returns true when the gamepiece is a duplicate" do
			subject.gamepieces = ["x"]
			subject.duplicate_gamepiece?("y").should be_false
		end

		it "returns true when the gamepiece is a duplicate" do
			subject.gamepieces = ["y"]
			subject.duplicate_gamepiece?("y").should be_true
		end
	end

end