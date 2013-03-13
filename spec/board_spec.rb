require 'spec_helper'

describe T3::Board do

  context "with a board_size of 3x3" do
    let(:subject) { T3::Board.new(9) }
  
    it "has an array of spaces that are strings" do
      subject.spaces = ["1","2","3","4","5","6","7","8","9"]
    end

    it "has a size of the board" do
      subject.size.should == 9
    end

    it "returns the number of spaces in the row/column" do
      subject.row_column_size.should == 3
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

    context "#invalid_move?" do
      it "returns true when input is a 0" do
        subject.invalid_move?(0).should be_true
      end

      it "returns true when input is greater than board size" do
        subject.invalid_move?(10).should be_true
      end

      it "returns true when a square is occupied" do
        subject.spaces = ["x","2","3","o","5","o","x","8","9"]
        subject.invalid_move?(6).should be_true
      end

      it "returns false when a square is not occupied and integer is valid" do
        subject.spaces = ["x","2","3","o","5","o","x","8","9"]
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
        subject.spaces = ["1","2","3","4","5","6","7","8","9"]
        subject.space_open?(9).should be_true
      end

      it "returns false when a square is occupied" do
        subject.spaces = ["x","2","3","o","5","o","x","8","9"]
        subject.space_open?(6).should be_false
      end
    end	
  end

  context "with a board_size of 4x4" do
    let(:subject) { T3::Board.new(16) }

    context "#invalid_move?" do
      it "returns true when input invalid" do
        subject.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
        subject.invalid_move?(17).should be_true
      end

      it "returns false when input valid and square is not occupied" do
        subject.spaces = ["1","x","3","o","x","o","7","8","x","x","o","12","o","14","o","o"]
        subject.invalid_move?(14).should be_false
      end

      it "returns true when input is valid and square is occupied" do
        subject.spaces = ["1","x","3","o","x","o","7","o","x","x","o","12","o","14","o","o"]
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
        subject.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
        subject.space_open?(14).should be_true
      end

      it "returns false when a square is occupied" do
        subject.spaces = ["x","2","3","o","5","o","x","8","9","10","11","12","13","14","o","16"]
        subject.space_open?(15).should be_false
      end
    end
  end

  context "with a board_size of 4x4" do
    let(:subject) { T3::Board.new(25) }

    context "#invalid_move?" do
      it "returns true when input is invalid" do
        subject.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
        subject.invalid_move?(26).should be_true
      end

      it "returns false when input valid and square is not occupied" do
        subject.spaces = ["1","x","3","o","x","o","7","8","x","x","o","12","o","14","o","o","17","x","19","20","21","x","23","24","25"]
        subject.invalid_move?(20).should be_false
      end

      it "returns true when input is valid and square is occupied" do
        subject.spaces = ["1","x","3","o","x","o","7","o","x","x","o","12","o","14","o","o","17","x","19","o","21","x","23","24","25"]
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
        subject.spaces = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","x","19","o","21","x","23","24","25"]
        subject.space_open?(21).should be_true
      end

      it "returns false when a square is occupied" do
        subject.spaces = ["x","2","3","o","5","o","x","8","9","10","11","12","13","14","o","16","17","x","19","o","21","x","23","24","25"]
        subject.space_open?(22).should be_false
      end
    end	
  end

end
