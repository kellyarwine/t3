require 'spec_helper'

describe T3::Minimax do
  let(:board)				{ T3::Board.new(9) }
  let(:game_rules)	{ T3::GameRules.new(board) }
  let(:console_io)	{ T3::ConsoleIo.new }
  let(:subject)			{ T3::Minimax.new(board,game_rules,console_io) }

  it "gets the best move available from a board with 4 available spaces" do
    subject.board.spaces = ["x","o","x","x","o","6","7","8","9"]
    # subject.board.spaces = ["x","o","x",
                            # "x","o","6",
                            # "7","8","9"]

    subject.get_move(["o","x"]).should == "8"
  end

  it "gets the best move available from a board with 6 available spaces" do
    subject.board.spaces = ["x","o","3","x","5","6","7","8","9"]
    # subject.board.spaces = ["x","o","3",
                            # "x","5","6",
                            # "7","8","9"]

    subject.get_move(["x","o"]).should == "7"
  end

  it "gets the best move available from a board with 5 available spaces" do
    subject.board.spaces = ["x","o","3","o","x","6","7","8","9"]
    # subject.board.spaces = ["x","o","3",
                            # "o","x","6",
                            # "7","8","9"]

    subject.get_move(["x","o"]).should == "9"
  end

  it "gets the best move available from a board with 7 available spaces" do
    subject.board.spaces = ["x","o","3","4","5","6","7","8","9"]
    # subject.board.spaces = ["1","2","3",
                            # "4","5","6",
                            # "7","8","9"]

    subject.get_move(["x","o"]).should == "3"
  end

  it "gets the best move available from a board with 8 available spaces" do
    subject.board.spaces = ["x","2","3","4","5","6","7","8","9"]
    # subject.board.spaces = ["x","2","3",
                            # "4","5","6",
                            # "7","8","9"]

    subject.get_move(["o","x"]).should == "5"
  end

  xit "gets the best move available from a board with 8 available spaces" do
    subject.board.spaces = ["1","2","3","4","5","6","7","8","9"]
    # subject.board.spaces = ["1","2","3",
                            # "4","5","6",
                            # "7","8","9"]

    subject.get_move(["o","x"]).should == "5"
  end

end
