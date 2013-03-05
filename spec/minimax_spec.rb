require 'spec_helper'

describe T3::Minimax do
  let(:board)				{ T3::Board.new(9) }
  let(:game_rules)	{ T3::GameRules.new(board) }
  let(:console_io)	{ T3::ConsoleIo.new }
  let(:subject)			{ T3::Minimax.new(board,game_rules,console_io) }

  it "scores a move when given a board of spaces" do
    subject.board.spaces = ["x","o","x","x","o","6","7","8","9"]
    # subject.board.spaces = ["x","o","x",
                            # "x","o","6",
                            # "7","8","9"]

                            # 6 7     => x wins
                            # 6 8 7 9 => draw
                            # 6 8 9 7 => x wins
                            # 6 9 7 8 => draw
                            # 6 9 8   => o wins                            

    subject.feed_scorer(board.available_spaces,["o","x"],0).should == [-1,2,1,-1]
  end
end
