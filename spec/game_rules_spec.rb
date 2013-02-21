require 'spec_helper'

describe GameRules do
	context "with a board_size of 3x3" do
		let(:board) 				{ Board.new(9) }
		let(:subject) 			{ GameRules.new(board) }
		
		context "#invalid_move?" do
			it "returns true when input is a 0" do
				subject.invalid_move?(0).should be_true
			end

			it "returns true when input is greater than board size" do
				subject.invalid_move?(10).should be_true
			end

			it "returns true when a square is occupied" do
				subject.board.spaces = ["x","2","3","o","5","o","x","8","9"]
				subject.invalid_move?(6).should be_true
			end

			it "returns false when a square is not occupied and integer is valid" do
				subject.board.spaces = ["x","2","3","o","5","o","x","8","9"]
				subject.invalid_move?(8).should be_false
			end
		end

		context "#valid_integer?" do
			it "returns true when input is a value between 1 and 9" do
				subject.valid_integer?(9).should be_true
			end

			it "returns true when input is a value between 1 and 9" do
				subject.valid_integer?(1).should be_true
			end

			it "returns true when input is a value between 1 and 9" do
				subject.valid_integer?(+9).should be_true
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?(0).should be_true
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?(-1).should be_true
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?(10).should be_true
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?("hello").should be_false
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?("a").should be_false
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?("\n").should be_false
			end

			it "returns false when input is a value not between 1 and 9" do
				subject.valid_integer?("").should be_false
			end
		end

		context "#in_board_range?" do
			it "returns true when input is a space on the board" do
				subject.in_board_range?(7).should be_true
			end

			it "returns true when input is a space on the board" do
				subject.in_board_range?(9).should be_true
			end

			it "returns false when input is a not space on the board" do
				subject.in_board_range?(0).should be_false
			end
		end

		context "#space_open?" do
			it "returns true when a square is not occupied" do
				subject.board.spaces = ["1","2","3","4","5","6","7","8","9"]
				subject.space_open?(9).should be_true
			end

			it "returns false when a square is occupied" do
				subject.board.spaces = ["x","2","3","o","5","o","x","8","9"]
				subject.space_open?(6).should be_false
			end
		end	

		context "#game_over?" do
			it "returns true when board is full and there are no wins" do
				subject.board.spaces = ["x","x","o","o","x","x","x","o","o"]
				subject.game_over?.should be_true
			end

			it "returns false when board is not full and there are no wins" do
				subject.board.spaces = ["x","2","o","o","x","x","x","o","o"]
				subject.game_over?.should be_false
			end

			it "returns true when board is not full and there are wins" do
				subject.board.spaces = ["x","2","o","o","x","o","o","o","x"]
				subject.game_over?.should be_true
			end		

			it "returns true when board is full and there are wins" do
				subject.board.spaces = ["x","o","o","o","x","o","x","o","x"]
				subject.game_over?.should be_true
			end		
		end

		context "#winning_gamepiece" do
			it "returns x when there are 3 x's in a row" do
				board.spaces = ["x","x","x","4","5","6","7","8","9"]
				subject.winning_gamepiece.should == "x"
			end

			it "returns x when there are 3 x's in a column" do
				board.spaces = ["x","2","3","x","5","6","x","8","9"]
				subject.winning_gamepiece.should == "x"
			end

			it "returns o when the left diagonal has 3 o's" do
				board.spaces = ["o","2","3","4","o","6","7","8","o"]
				subject.winning_gamepiece.should == "o"
			end

			it "returns o when the right diagonal has 3 o's" do
				board.spaces = [1,2,"o",4,"o",6,"o",8,9]
				subject.winning_gamepiece.should == "o"
			end

			it "returns false when a game is not won" do
				subject.board.spaces = ["1","2","3","4","5","6","7","8","9"]
				subject.winning_gamepiece.should be_nil
			end

			it "returns false when a game is a draw" do
				board.spaces = ["x","o","x","o","x","o","o","x","o"]
				subject.winning_gamepiece.should be_nil
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

		context "#left_diagonal_contents" do
			it "returns an array of 1 array with the values from the left diagonal" do
				board.spaces = ["x","x","o","o","o","o","x","x","o"]
				subject.left_diagonal_contents.should == [["x","o","o"]]
			end

			it "returns an array of 1 array with the values from the left diagonal" do
				board.spaces = ["x","o","x","x","o","x","x","o","x"]
				subject.left_diagonal_contents.should == [["x","o","x"]]
			end
		end

		context "#right_diagonal_contents" do
			it "returns an array of 1 array with the values from the right diagonal" do
				board.spaces = ["x","x","o","o","o","o","x","x","o"]
				subject.right_diagonal_contents.should == [["o","o","x"]]
			end

			it "returns an array of 1 array with the values from the right diagonal" do
				board.spaces = ["x","x","o","x","x","o","x","x","o"]
				subject.right_diagonal_contents.should == [["o","x","x"]]
			end
		end
	end

	context "with a board_size of 4x4" do
		let(:board) 				{ Board.new(16) }
		let(:subject) 			{ GameRules.new(board) }
		
		context "#invalid_move?" do
			it "returns true when input invalid" do
				subject.board.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
				subject.invalid_move?(17).should be_true
			end

			it "returns false when input valid and square is not occupied" do
				subject.board.spaces = ["1","x","3","o","x","o","7","8","x","x","o","12","o","14","o","o"]
				subject.invalid_move?(14).should be_false
			end

			it "returns true when input is valid and square is occupied" do
				subject.board.spaces = ["1","x","3","o","x","o","7","o","x","x","o","12","o","14","o","o"]
				subject.invalid_move?(8).should be_true
			end
		end

		context "#valid_integer?" do
			it "returns true when input is not a value between 1 and 16" do
				subject.valid_integer?(0).should be_true
			end

			it "returns true when input is not a value between 1 and 16" do
				subject.valid_integer?(17).should be_true
			end

			it "returns true when input is a value between 1 and 16" do
				subject.valid_integer?(8).should be_true
			end
		end

		context "#in_board_range?" do
			it "returns true when input is a space on the board" do
				subject.in_board_range?(14).should be_true
			end

			it "returns true when input is a space on the board" do
				subject.in_board_range?(16).should be_true
			end

			it "returns false when input is a not space on the board" do
				subject.in_board_range?(18).should be_false
			end
		end

		context "#space_open?" do
			it "returns true when a square is not occupied" do
				subject.board.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
				subject.space_open?(14).should be_true
			end

			it "returns false when a square is occupied" do
				subject.board.spaces = ["x","2","3","o","5","o","x","8","9","10","11","12","13","14","o","16"]
				subject.space_open?(15).should be_false
			end
		end	

		context "#game_over?" do
			it "returns true when board is full and there are no wins" do
				subject.board.spaces = ["x","x","o","o","o","o","x","x","o","x","o","x","o","x","o","o"]
				subject.game_over?.should be_true
			end
		end

		context "#winning_gamepiece" do
			it "returns x when there are 4 x's in a diagonal" do
				board.spaces = ["x","o","x","o","x","o","x","o","x","x","o","x","x","x","o","x"]			
				subject.winning_gamepiece.should == "x"
			end
		end

		it "returns an array of 4 arrays with the values from each row contained in one array" do
			board.spaces = ["x","o","x","o","x","o","x","o","x","x","o","x","o","x","o","x"]
			subject.row_contents.should == [["x","o","x","o"],["x","o","x","o"],["x","x","o","x"],["o","x","o","x"]]
		end

		it "returns an array of 4 arrays with the values from each column contained in one array" do
			board.spaces = ["x","o","x","o","x","o","x","o","x","x","o","x","o","x","o","x"]
			subject.column_contents.should == [["x","x","x","o"],["o","o","x","x"],["x","x","o","o"],["o","o","x","x"]]
		end	

		it "returns an array of 1 array with the values from the left diagonal" do
			board.spaces = ["x","o","x","o","x","o","x","o","x","x","o","x","o","x","o","x"]
			subject.left_diagonal_contents.should == [["x","o","o","x"]]
		end

		it "returns an array of 1 array with the values from the right diagonal" do
			board.spaces = ["x","o","x","o","x","o","x","o","x","x","o","x","o","x","o","x"]
			subject.right_diagonal_contents.should == [["o","x","x","o"]]
		end
	end

	context "with a board_size of 5x5" do
		let(:board) 				{ Board.new(25) }
		let(:subject) 			{ GameRules.new(board) }
		
		context "#invalid_move?" do
			it "returns true when input is invalid" do
				subject.board.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
				subject.invalid_move?(26).should be_true
			end

			it "returns false when input valid and square is not occupied" do
				subject.board.spaces = ["1","x","3","o","x","o","7","8","x","x","o","12","o","14","o","o","17","x","19","20","21","x","23","24","25"]
				subject.invalid_move?(20).should be_false
			end

			it "returns true when input is valid and square is occupied" do
				subject.board.spaces = ["1","x","3","o","x","o","7","o","x","x","o","12","o","14","o","o","17","x","19","o","21","x","23","24","25"]
				subject.invalid_move?(22).should be_true
			end
		end

		it "returns true when input is not a value between 1 and 25" do
			subject.valid_integer?(26).should be_true
		end

		context "#in_board_range?" do
			it "returns true when input is a space on the board" do
				subject.in_board_range?(25).should be_true
			end

			it "returns false when input is a not space on the board" do
				subject.in_board_range?(26).should be_false
			end
		end

		context "#space_open?" do
			it "returns true when a square is not occupied" do
				subject.board.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","x","19","o","21","x","23","24","25"]
				subject.space_open?(21).should be_true
			end

			it "returns false when a square is occupied" do
				subject.board.spaces = ["x","2","3","o","5","o","x","8","9","10","11","12","13","14","o","16","17","x","19","o","21","x","23","24","25"]
				subject.space_open?(22).should be_false
			end
		end	

		context "#game_over?" do
			it "returns true when board is full and there are no wins" do
				subject.board.spaces = ["x","x","o","o","x","o","o","x","x","o","x","o","x","o","x","o","o","x","o","x","o","x","o","x","o"]
				subject.game_over?.should be_true
			end
		end

		context "#winning_gamepiece" do
			it "returns x when there are 5 x's in a diagonal" do
				subject.board.spaces = ["x","x","o","o","x","o","x","x","x","o","x","o","x","o","x","o","o","x","x","x","o","x","o","x","x"]
				subject.winning_gamepiece.should == "x"
			end
		end

		it "returns an array of 5 arrays with the values from each row contained in one array" do
			subject.board.spaces = ["x","x","o","o","x","o","x","x","x","o","x","o","x","o","x","o","o","x","x","x","o","x","o","x","x"]
			subject.row_contents.should == [["x","x","o","o","x"],["o","x","x","x","o"],["x","o","x","o","x"],["o","o","x","x","x"],["o","x","o","x","x"]]
		end

		it "returns an array of 5 arrays with the values from each column contained in one array" do
			subject.board.spaces = ["x","x","o","o","x","o","x","x","x","o","x","o","x","o","x","o","o","x","x","x","o","x","o","x","x"]
			subject.column_contents.should == [["x","o","x","o","o"],["x","x","o","o","x"],["o","x","x","x","o"],["o","x","o","x","x"],["x","o","x","x","x"]]
		end	

		it "returns an array of 1 array with the values from the left diagonal" do
			subject.board.spaces = ["x","x","o","o","x","o","x","x","x","o","x","o","x","o","x","o","o","x","x","x","o","x","o","x","o"]
			subject.left_diagonal_contents.should == [["x","x","x","x","o"]]
		end

		it "returns an array of 1 array with the values from the right diagonal" do
			subject.board.spaces = ["x","x","o","o","x","o","x","x","x","o","x","o","x","o","x","o","o","x","x","x","o","x","o","x","x"]
			subject.right_diagonal_contents.should == [["x","x","x","o","o"]]
		end
	end

end	