require 'spec_helper'

describe T3::GameRules do
  context "with a board_size of 3x3" do
    let(:board) 				{ T3::Board.new(3) }
    let(:subject) 			{ T3::GameRules.new(board) }

    it "initializes board" do
      subject.board.should be_kind_of(T3::Board)
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

    context "#board_full?" do
      it "returns false when there are no more moves to make" do
        subject.board.spaces = ["x","x","x","o","o","o","o","x","x"]
        subject.board_full?.should be_true
      end

      it "returns true when there are still moves to make" do
        subject.board.spaces = ["x","x","x","4","o","o","o","x","x"]
        subject.board_full?.should be_false
      end
    end

    context "#win_game?" do
      it "returns false when the game was a draw" do
        subject.board.spaces = ["x","x","o","o","x","x","x","o","o"]
        subject.win_game?.should be_false
      end

      it "returns true when someone won the game" do
        subject.board.spaces = ["x","x","x","4","o","o","o","x","x"]
        subject.win_game?.should be_true
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
    let(:board) 				{ T3::Board.new(4) }
    let(:subject) 			{ T3::GameRules.new(board) }

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
    let(:board) 				{ T3::Board.new(5) }
    let(:subject) 			{ T3::GameRules.new(board) }

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
