require 'spec_helper'

describe T3::Game do

  let(:board)               { T3::Board.new(4)                        }
  let(:game_rules)          { T3::GameRules.new(board)                }
  let(:validations)         { T3::Validations.new                     }
  let(:player_1)            { T3::Player::Human.new("x")              }
  let(:player_2)            { T3::Player::EasyAi.new("o")             }
  let(:player_3)            { T3::Player::Minimax.new("o",game_rules) }
  let(:players)             { [player_1,player_2]                     }
  let(:players_2)           { [player_3,player_1]                     }
  let(:subject)             { T3::Game.new(double(:configurations, players: players, board: board, game_rules: game_rules, validations: validations, player_1: player_1, player_2: player_2))   }
  let(:game_with_player_3)  { T3::Game.new(double(:configurations, players: players_2, board: board, game_rules: game_rules, validations: validations, player_1: player_1, player_2: player_3)) }

  it "fires all 'game loop' events" do
    subject.should_receive(:place_move)
    subject.should_receive(:switch_current_player)
    subject.game_loop("1")
  end

  context "#switch_current_player" do
    it "reverses the players in the players array" do
      subject.switch_current_player
      subject.players.should == [player_2,player_1]
    end

    it "reverses the players in the players array two times" do
      subject.switch_current_player
      subject.switch_current_player
      subject.players.should == [player_1,player_2]
    end
  end

  it "returns the first player from players as the current player" do
    subject.switch_current_player
    subject.switch_current_player
    subject.current_player.should == player_1
  end

  it "returns the game state" do
    subject.game_rules.should_receive(:game_state)
    subject.game_state
  end

  it "places a move" do
    subject.board.should_receive(:place_move)
    subject.place_move("1")
  end

end
