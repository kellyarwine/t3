require 'spec_helper'

describe Minimax do
  let(:board)				{ Board.new(9) }
  let(:game_rules)	{ GameRules.new(board) }
  let(:console_io)	{ ConsoleIo.new }
  let(:subject)			{ Minimax.new(board,game_rules,console_io) }

  it "scores a move when given a board of spaces" do
    # subject.board.spaces = ["x","o","x","x","x","6","7","8","9"]
    # subject.board.spaces = ["x","o","x",
                            # "x","x","6",
                            # "7","8","9"]
    # subject.run_scorer(board.available_spaces).should == "x"
  end
end