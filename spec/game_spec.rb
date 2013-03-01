require 'spec_helper'

describe Game do
	let(:console_io)			{ ConsoleIo.new												}
	let(:configurations)	{ Configurations.new(console_io)			}
	let(:board)						{ Board.new(16)												}
	let(:player_1)				{ EasyAi.new("x",)										}
	let(:player_2)				{ Human.new("o",console_io)						}
	let(:game_rules)			{ GameRules.new(board)								}
	let(:players)					{ [player_1, player_2]								}
	let(:subject)					{ Game.new(console_io, double(:configurations, players: players, board: board, game_rules: game_rules, console_io: console_io, player_1: player_1, player_2: player_2))	}


	context "#run_game" do
		it "runs game loop once with no invalid moves then game is a draw" do
			subject.game_rules.should_receive(:game_over?).and_return(false,true)
			subject.console_io.should_receive(:display_welcome_message)
			subject.console_io.should_receive(:display_gameboard).exactly(2).times
			subject.console_io.should_receive(:display_request_for_move)
			subject.player_1.should_receive(:get_move).and_return(2)
			subject.board.should_receive(:place_move)
			subject.game_rules.should_receive(:win_game?).and_return(false)			
			subject.console_io.should_receive(:display_draw)
			subject.start_game
		end

		it "runs game loop 3 times and then game is a draw" do
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
			subject.console_io.should_receive(:display_welcome_message)
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.console_io.should_receive(:display_request_for_move).exactly(3).times
			subject.player_1.should_receive(:get_move).and_return(2,1)
			subject.player_2.should_receive(:get_move).and_return(4)
			subject.board.should_receive(:place_move).exactly(3).times
			subject.game_rules.should_receive(:win_game?).and_return(false)
			subject.console_io.should_receive(:display_draw)
			subject.start_game
		end

		it "runs game loop 3 times and then game is won" do
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
			subject.console_io.should_receive(:display_welcome_message)
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.console_io.should_receive(:display_request_for_move).exactly(3).times
			subject.player_1.should_receive(:get_move).and_return(2,1)
			subject.player_2.should_receive(:get_move).and_return(4)
			subject.board.should_receive(:place_move).exactly(3).times
			subject.game_rules.should_receive(:win_game?).and_return(true)
			subject.console_io.should_receive(:display_win)
			subject.start_game
		end

		it "runs game loop 3 times and then game is won" do
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
			subject.console_io.should_receive(:display_welcome_message)
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.console_io.should_receive(:display_request_for_move).exactly(3).times
			subject.player_1.should_receive(:get_move).and_return(2,1)
			subject.player_2.should_receive(:get_move).and_return(4)
			subject.board.should_receive(:place_move).exactly(3).times
			subject.game_rules.should_receive(:win_game?).and_return(true)
			subject.console_io.should_receive(:display_win)
			subject.start_game
		end

		it "runs game loop 4 times with 2 invalid moves then game is a draw" do
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,true)
			subject.console_io.should_receive(:display_welcome_message)
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.console_io.should_receive(:display_request_for_move).exactly(5).times
			subject.player_1.should_receive(:get_move).and_return(2,100,3)
			subject.player_2.should_receive(:get_move).and_return(17,4)
			subject.game_rules.should_receive(:invalid_move?).and_return(false,true,false,true,false)
			subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
			subject.board.should_receive(:place_move).exactly(3).times
			subject.game_rules.should_receive(:win_game?).and_return(false)
			subject.console_io.should_receive(:display_draw)
			subject.start_game
		end
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

end