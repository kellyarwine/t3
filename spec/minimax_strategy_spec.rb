require 'spec_helper'

describe T3::Player::MinimaxStrategy do

  let(:gamepiece)           { "x"                                       }
  let(:board)               { T3::Board.new(3)                          }
  let(:game_rules)          { T3::GameRules.new(board)                  }
  let(:subject)             { T3::Player::MinimaxStrategy.new(gamepiece,game_rules) }

  it 'has a piece' do
    T3::Player::MinimaxStrategy.new("x",game_rules).piece.should == gamepiece
  end

  it "initializes game rules" do
    subject.game_rules.should be_kind_of(T3::GameRules)
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "gets the best move available from a board with 2 available spaces" do
    board.spaces = ["o","x","o","o","x","o","7","8","x"]
  # board.spaces = ["o","x","o",
                  # "o","x","o",
                  # "7","8","o"]

    subject.move(board,["x","o"]).should == 8
  end

  it "gets the best move available from a board with 3 available spaces" do
    board.spaces = ["1","o","x","x","o","x","7","8","o"]
  # board.spaces = ["1","o","x",
                  # "x","o","x",
                  # "7","8","o"]

    subject.move(board,["x","o"]).should == 1
  end

  it "gets the best move available from a board with 3 available spaces" do
    board.spaces = ["x","o","x","o","x","o","7","8","9"]
  # board.spaces = ["x","o","x",
                  # "x","o","x",
                  # "7","8","9"]
    subject.move(board,["x","o"]).should == 7
  end

  it "gets the best move available from a board with 4 available spaces" do
    board.spaces = ["x","x","o","x","o","6","7","8","9"]
  # board.spaces = ["x","x","o",
                  # "x","o","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 7
  end

  it "gets the best move available from a board with 5 available spaces" do
    board.spaces = ["x","o","o","x","5","6","o","8","9"]
  # board.spaces = ["x","o","o",
                  # "x","5","6",
                  # "o","8","9"]
    subject.move(board,["x","o"]).should == 5
  end

  it "gets the best move available from a board with 6 available spaces" do
    board.spaces = ["x","o","3","x","5","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "x","5","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 7
  end

  it "gets the best move available from a board with 5 available spaces" do
    board.spaces = ["x","o","3","o","x","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "o","x","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 9
  end

  it "gets the best move available from a board with 6 available spaces" do
    board.spaces = ["x","o","3","4","o","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "4","o","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 8
  end

  it "gets the best move available from a board with 6 available spaces" do
    board.spaces = ["x","o","3","4","x","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "4","x","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 9
  end

  it "gets the best move available from a board with 8 available spaces" do
    board.spaces = ["o","2","3","4","5","6","7","8","9"]
  # board.spaces = ["o","2","3",
                  # "4","5","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 5
  end

  it "gets the best move available from a board with 9 available spaces" do
    board.spaces = ["1","2","3","4","5","6","7","8","9"]
  # board.spaces = ["1","2","3",
                  # "4","5","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 1
  end

  it "gets the best move available from a board with 5 available spaces (Anish test)" do
    board.spaces = ["o","x","o","x","5","6","7","8","9"]
  # board.spaces = ["o","x","o",
                  # "x","5","6",
                  # "7","8","9"]

    subject.move(board,["x","o"]).should == 5
  end


end
