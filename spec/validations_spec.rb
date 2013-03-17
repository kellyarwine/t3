require 't3/validations'

describe T3::Validations do
  let(:board) 	   { T3::Board.new(3)           }
  let(:console_io) { T3::ConsoleIo.new(board)   }
  let(:subject)    { T3::Validations.new(board) }

  context "with a board_size of 3x3" do
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
  end

  context "with a board_size of 4x4" do
    let(:board) { T3::Board.new(4) }
    let(:subject)    { T3::Validations.new(board) }

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
  end

  context "with a board_size of 5x5" do
    let(:board) { T3::Board.new(5) }
    let(:subject)    { T3::Validations.new(board) }

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
  end

  context "#invalid_gamepiece?" do
    it "returns false when the gamepiece is valid" do
      subject.invalid_gamepiece?("j").should be_false
    end

    it "returns true when the gamepiece is invalid" do
      subject.invalid_gamepiece?("ab").should be_true
    end

    it "returns true when the gamepiece is invalid" do
      subject.invalid_gamepiece?("1").should be_true
    end

    it "returns true when the gamepiece is invalid" do
      subject.invalid_gamepiece?("40").should be_true
    end
  end

  it "stores a gamepiece in the gamepieces array" do
    subject.store_gamepiece("x")
    subject.gamepieces.should == ["x"]
  end

  context "#gamepieces" do
    it "has a gamepieces array" do
      subject.gamepieces.should be_kind_of(Array)
    end

    it "creates a new gamepieces array if one does not already exist" do
      subject.gamepieces.should == []
    end

    it "returns the existing gamepieces array if one already exists" do
      subject.gamepieces = ["x"]
      subject.gamepieces.should == ["x"]
    end
  end
end