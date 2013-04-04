require 'spec_helper'

describe Console::Console do

    let(:spaces)      { ["x","x","o","o","o","o","x","x","o"]     }
    let(:board)       { T3::Board.new(3)                          }
    let(:game_rules)  { T3::GameRules.new(board)                  }
    let(:player_1)    { T3::Player::EasyAi.new("x")               }
    let(:player_2)    { T3::Player::Minimax.new("x", game_rules)  }
    let(:player_3)    { T3::Player::Human.new("x")                }

  it "initializes the io, prompter, configurations and game" do
    subject.io.should be_kind_of(Console::Io)
    subject.prompter.should be_kind_of(Console::Prompter)
    subject.configurations.should be_kind_of(T3::Configurations)
    subject.game.should be_kind_of(T3::Game)
  end

  it "runs the game" do
    subject.should_receive(:configure_game).exactly(2).times
    subject.should_receive(:play_game).exactly(2).times
    subject.prompter.should_receive(:play_again?).and_return(true, false)
    subject.run_game
  end

  it "configures the game correctly" do
    subject.prompter.should_receive(:board_size).and_return(3)
    subject.prompter.should_receive(:opponent).and_return("2")
    subject.prompter.should_receive(:human_gamepiece).and_return("o")
    subject.prompter.should_receive(:opponent_gamepiece).and_return("x")
    subject.prompter.should_receive(:turn_order).and_return("2")
    subject.configure_game
    subject.game.board.should be_kind_of(T3::Board)
    subject.game.player_1.should be_kind_of(T3::Player::Human)
    subject.game.player_2.should be_kind_of(T3::Player::Minimax)
    subject.game.player_1.piece.should == "o"
    subject.game.player_2.piece.should == "x"
    subject.game.players.should == [subject.game.player_2, subject.game.player_1]
  end

  it "plays one turn of a game that then ends in a draw" do
    subject.configurations.board = board
    subject.io.should_receive(:display_welcome_message)
    subject.game.should_receive(:game_state).and_return("","draw","draw")
    subject.io.should_receive(:display_gameboard).exactly(2).times
    subject.should_receive(:get_move).exactly(1).times
    subject.game.should_receive(:game_loop).exactly(1).times
    subject.io.should_receive(:display_draw)
    subject.play_game
  end

  it "plays one turn of a game that then ends in a win" do
    subject.configurations.board = board
    subject.configurations.game_rules = game_rules
    subject.io.should_receive(:display_welcome_message)
    subject.game.should_receive(:game_state).and_return("","x","x")
    subject.io.should_receive(:display_gameboard).exactly(2).times
    subject.should_receive(:get_move).exactly(1).times
    subject.game.should_receive(:game_loop).exactly(1).times
    subject.io.should_receive(:display_win)
    subject.game.game_rules.should_receive(:winning_gamepiece)
    subject.play_game
  end

  it "calls the move method for a Easy AI opponent" do
    subject.game.should_receive(:current_player).exactly(3).times.and_return(player_1)
    subject.game.current_player.should_receive(:move)
    subject.get_move
  end

  it "calls the move method for a Hard AI opponent" do
    subject.configurations.player_1 = player_1
    subject.configurations.player_2 = player_2
    subject.configurations.players = [player_1, player_2]
    subject.game.should_receive(:current_player).exactly(3).times.and_return(player_2)
    subject.game.current_player.should_receive(:move)
    subject.get_move
  end

  it "calls the move method for a human opponent" do
    subject.game.should_receive(:current_player).and_return(player_3)
    subject.prompter.should_receive(:human_move)
    subject.get_move
  end

end
