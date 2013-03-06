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

                            # 6 7     => x wins => -.5
                            # 6 8 7 9 => draw
                            # 6 8 9 7 => x wins => -.25
                            # 6 9 7 8 => draw
                            # 6 9 8   => o wins => .333
                            # 7 6 8   => o wins => .333
                            # 7 6 9 8 => draw
                            # 7 8 6 9 => draw
                            # 7 8 9 6 => draw
                            # 7 9 8   => o wins => .333
                            # 7 9 6 8 => draw
                            # 8       => o wins => 1.0
                            # 9 6 7 8 => draw
                            # 9 6 8   => o wins => .333
                            # 9 7     => x wins => -.5
                            # 9 8 6 7 => x wins => -.25
                            # 9 8 7 6 => draw

    subject.feed_scorer(board.available_spaces,["o","x"],0.0).should == [-0.417,0.667,1.0,-0.417]
  end
end
