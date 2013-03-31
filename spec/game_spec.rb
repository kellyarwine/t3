require 'spec_helper'

describe T3::Game do

  let(:board)               { T3::Board.new(4)                                                                }
  let(:game_rules)          { T3::GameRules.new(board)                                                        }
  let(:validations)         { T3::Validations.new                                                             }
  let(:io)                  { T3::Io.new                                                     }
  let(:player_1)            { T3::Player::PlayerContext.new(T3::Player::HumanStrategy.new("x",io))            }
  let(:player_2)            { T3::Player::PlayerContext.new(T3::Player::EasyAiStrategy.new("o"))              }
  let(:player_3)            { T3::Player::PlayerContext.new(T3::Player::MinimaxStrategy.new("o",game_rules))  }
  let(:players)             { [player_1,player_2]                                                             }
  let(:players_2)           { [player_3,player_1]                                                             }
  let(:subject)             { T3::Game.new(io, double(:configurations, players: players, board: board, game_rules: game_rules, validations: validations, io: io, player_1: player_1, player_2: player_2))   }
  let(:game_with_player_3)  { T3::Game.new(io, double(:configurations, players: players_2, board: board, game_rules: game_rules, validations: validations, io: io, player_1: player_1, player_2: player_3)) }

  it "fires all 'start game' events when starting game" do
    subject.io.should_receive(:display_welcome_message)
    subject.should_receive(:run_game)
    subject.start_game
  end

  it "fires all 'run game' events when running game and runs 1 game loop" do
    subject.should_receive(:game_over?).and_return(false,true)
    subject.should_receive(:display_gameboard)
    subject.should_receive(:get_move)
    subject.should_receive(:place_move)
    subject.should_receive(:switch_current_player)
    subject.should_receive(:display_gameboard)
    subject.should_receive(:win_game?).and_return(true)
    subject.should_receive(:display_win)
    subject.run_game
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

  context "#get_move" do
    it "returns a move for an easy AI player" do
      subject.io.should_receive(:display_request_for_move)
      subject.switch_current_player
      subject.get_move
      subject.move.should >= 1
      subject.move.should <= board.size**2
    end

    it "returns a move for a human player" do
      subject.io.should_receive(:display_request_for_move)
      subject.player_1.should_receive(:move).and_return(10)
      subject.get_move
      subject.move.should == 10
    end

    it "returns a move for a hard AI player" do
      game_with_player_3.io.should_receive(:display_request_for_move)
      game_with_player_3.get_move
      game_with_player_3.move.should >= 1
      game_with_player_3.move.should <= board.size**2
    end
  end

  context "integration testing" do
    it "runs game loop once with no invalid moves then game is a draw" do
      subject.io.should_receive(:display_welcome_message)
      subject.game_rules.should_receive(:game_over?).and_return(false,true)
      subject.io.should_receive(:display_gameboard).exactly(2).times
      subject.io.should_receive(:display_request_for_move)
      subject.player_1.should_receive(:move).and_return(2)
      subject.board.should_receive(:place_move)
      subject.game_rules.should_receive(:win_game?).and_return(false)
      subject.io.should_receive(:display_draw)
      subject.start_game
    end

    it "runs game loop 3 times and then game is a draw" do
      subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
      subject.io.should_receive(:display_welcome_message)
      subject.io.should_receive(:display_gameboard).exactly(4).times
      subject.io.should_receive(:display_request_for_move).exactly(3).times
      subject.player_1.should_receive(:move).and_return(2,1)
      subject.player_2.should_receive(:move).and_return(4)
      subject.board.should_receive(:place_move).exactly(3).times
      subject.game_rules.should_receive(:win_game?).and_return(false)
      subject.io.should_receive(:display_draw)
      subject.start_game
    end

    it "runs game loop 3 times and then game is won" do
      subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
      subject.io.should_receive(:display_welcome_message)
      subject.io.should_receive(:display_gameboard).exactly(4).times
      subject.io.should_receive(:display_request_for_move).exactly(3).times
      subject.player_1.should_receive(:move).and_return(2,1)
      subject.player_2.should_receive(:move).and_return(4)
      subject.board.should_receive(:place_move).exactly(3).times
      subject.game_rules.should_receive(:win_game?).and_return(true)
      subject.io.should_receive(:display_win)
      subject.start_game
    end

    it "runs game loop 3 times and then game is won" do
      subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
      subject.io.should_receive(:display_welcome_message)
      subject.io.should_receive(:display_gameboard).exactly(4).times
      subject.io.should_receive(:display_request_for_move).exactly(3).times
      subject.player_1.should_receive(:move).and_return(2,1)
      subject.player_2.should_receive(:move).and_return(4)
      subject.board.should_receive(:place_move).exactly(3).times
      subject.game_rules.should_receive(:win_game?).and_return(true)
      subject.io.should_receive(:display_win)
      subject.start_game
    end

    it "runs game loop 4 times with 2 invalid moves then game is a draw" do
      subject.game_rules.should_receive(:game_over?).and_return(false,false,false,false,true)
      subject.io.should_receive(:display_welcome_message)
      subject.io.should_receive(:display_gameboard).exactly(5).times
      subject.io.should_receive(:display_request_for_move).exactly(6).times
      subject.player_1.should_receive(:move).and_return(2,100,3)
      subject.player_2.should_receive(:move).and_return(17,4,5)
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.board.should_receive(:place_move).exactly(4).times
      subject.game_rules.should_receive(:win_game?).and_return(false)
      subject.io.should_receive(:display_draw)
      subject.start_game
    end
  end

end
