require 'spec_helper'

describe T3::Player::Minimax do
  let(:human_gamepiece)     { "o"                                                                  }
  let(:piece)               { "x"                                                                  }
  let(:console_io)          { T3::ConsoleIo.new                                                    }
  let(:board)               { T3::Board.new(3)                                                     }
  let(:game_rules)          { T3::GameRules.new(board)                                             }
  let(:subject)             { T3::Player::Minimax.new(human_gamepiece,piece,game_rules,console_io) }

  it 'has a piece' do
    T3::Player::Minimax.new("o","x",game_rules,console_io).piece.should == piece
  end

  it "should not be human" do
    subject.human?.should == false
  end

  it "gets the best move available from a board with 2 available spaces" do
    board.spaces = ["o","x","o","o","x","o","7","8","x"]
  # board.spaces = ["o","x","o",
                  # "o","x","o",
                  # "7","8","o"]

    subject.get_move(board,["x","o"]).should == 8
  end

  it "gets the best move available from a board with 3 available spaces" do
    board.spaces = ["1","o","x","x","o","x","7","8","o"]
  # board.spaces = ["1","o","x",
                  # "x","o","x",
                  # "7","8","o"]

    subject.get_move(board,["x","o"]).should == 1
  end


  it "gets the best move available from a board with 3 available spaces" do
    board.spaces = ["x","o","x","o","x","o","7","8","9"]
  # board.spaces = ["x","o","x",
                  # "x","o","x",
                  # "7","8","9"]
    subject.get_move(board,["x","o"]).should == 7
  end

  it "gets the best move available from a board with 4 available spaces" do
    board.spaces = ["x","x","o","x","o","6","7","8","9"]
  # board.spaces = ["x","x","o",
                  # "x","o","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 7
  end

  it "gets the best move available from a board with 5 available spaces" do
    board.spaces = ["x","o","o","x","5","6","o","8","9"]
  # board.spaces = ["x","o","o",
                  # "x","5","6",
                  # "o","8","9"]
    subject.get_move(board,["x","o"]).should == 5
  end

  it "gets the best move available from a board with 6 available spaces" do
    board.spaces = ["x","o","3","x","5","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "x","5","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 7
  end

  it "gets the best move available from a board with 5 available spaces" do
    board.spaces = ["x","o","3","o","x","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "o","x","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 9
  end

  it "gets the best move available from a board with 6 available spaces" do
    board.spaces = ["x","o","3","4","o","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "4","o","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 8
  end

  it "gets the best move available from a board with 6 available spaces" do
    board.spaces = ["x","o","3","4","x","6","7","8","9"]
  # board.spaces = ["x","o","3",
                  # "4","x","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 9
  end

  it "gets the best move available from a board with 8 available spaces" do
    board.spaces = ["o","2","3","4","5","6","7","8","9"]
  # board.spaces = ["o","2","3",
                  # "4","5","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 5
  end

  it "gets the best move available from a board with 9 available spaces" do
    board.spaces = ["1","2","3","4","5","6","7","8","9"]
  # board.spaces = ["1","2","3",
                  # "4","5","6",
                  # "7","8","9"]

    subject.get_move(board,["x","o"]).should == 1
  end

end
