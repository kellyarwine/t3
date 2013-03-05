require 'spec_helper'

describe T3::Minimax do
  let(:board)				{ T3::Board.new(9) }
  let(:game_rules)	{ T3::GameRules.new(board) }
  let(:console_io)	{ T3::ConsoleIo.new }
  let(:subject)			{ T3::Minimax.new(board,game_rules,console_io) }

  it "scores a move when given a board of spaces" do
    subject.board.spaces = ["x","o","x","x","o","6","7","8","9"]
    # subject.board.spaces = ["x","o","x",
                            # "x","x","6",
                            # "7","8","9"]
    subject.run_scorer(board.available_spaces,["o","x"],0).should == "x"
  end
end
