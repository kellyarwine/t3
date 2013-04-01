require 'spec_helper'

describe T3::Player::PlayerContext do

  let(:player_strategy_1) { T3::Player::EasyAiStrategy.new("x")              }
  let(:player_strategy_2) { T3::Player::MinimaxStrategy.new("x",game_rules)  }
  let(:player_strategy_3) { T3::Player::HumanStrategy.new("x",prompter)      }
  let(:board)             { T3::Board.new(3)                                 }
  let(:game_rules)        { T3::GameRules.new(board)                         }
  let(:prompter)          { T3::Prompter.new                                 }
  let(:gamepieces)        { ["x","o"]                                        }
  let(:player_context_1)  { T3::Player::PlayerContext.new(player_strategy_1) }
  let(:player_context_2)  { T3::Player::PlayerContext.new(player_strategy_2) }
  let(:player_context_3)  { T3::Player::PlayerContext.new(player_strategy_3) }

  it "initializes a strategy" do
    player_context_1.strategy.should == player_strategy_1
  end

  it "has a piece" do
    player_context_1.piece.should == "x"
  end

  it "is not a human" do
    player_context_1.human?.should == false
  end

  it "should return a move for easy AI if the board is passed in" do
    player_context_1.move(board).should >= 1
    player_context_1.move(board).should <= board.size**2
  end

  it "should return a move for hard AI if the board and gamepieces are passed in" do
    player_context_2.move(board,gamepieces).should >= 1
    player_context_2.move(board,gamepieces).should <= board.size**2
  end

  it "should return a move for huamn if no arguments are passed in" do
    player_strategy_3.prompter.should_receive(:human_move).and_return(10)
    player_context_3.move(board).should == 10
  end

end
