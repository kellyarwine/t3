require 'spec_helper'

describe Game do
	let(:board) 						{ Board.new										}
	let(:console_io)				{ ConsoleIo.new(board)				}
	let(:game_rules)				{ GameRules.new								}
	let(:subject)						{ Game.new(board, console_io)	}

	it "instantiates the Game class correctly" do
		subject.game_rules.should be_kind_of(GameRules)
		subject.board.should be_kind_of(Board)
		subject.console_io.should be_kind_of(ConsoleIo)
		subject.current_player.should == subject.player_1
	end

	it "sets up the game correctly" do
		subject.should_receive(:display_and_get_gamepiece).and_return("Q", "V")
		subject.setup_game
		subject.player_1.piece.should == "Q"
		subject.player_2.piece.should == "V"
	end

	context "#run_game" do
		it "runs game loop once with move that's not invalid until game is over" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(1).times
			subject.game_rules.should_receive(:invalid_move?).and_return(false)
			subject.board.should_receive(:place_move).exactly(1).times
			subject.console_io.should_receive(:display_gameboard).exactly(1).times
			subject.should_receive(:switch_current_player).exactly(1).times
			subject.console_io.should_receive(:display_draw).exactly(1).times			
			subject.run_game
		end

		it "runs game loop once with 1 invalid input until game is over" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(2).times
			subject.game_rules.should_receive(:invalid_move?).and_return(true, false)
			subject.console_io.should_receive(:display_invalid_move).exactly(1).times
			subject.board.should_receive(:place_move).exactly(1).times
			subject.console_io.should_receive(:display_gameboard).exactly(1).times
			subject.should_receive(:switch_current_player).exactly(1).times
			subject.console_io.should_receive(:display_draw).exactly(1).times			
			subject.run_game
		end

		it "runs game loop 4 times with 2 invalid inputs until game is over" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(6).times
			subject.game_rules.should_receive(:invalid_move?).and_return(true,false,false,true,false,false)
			subject.console_io.should_receive(:display_invalid_move).exactly(2).times
			subject.board.should_receive(:place_move).exactly(4).times
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.should_receive(:switch_current_player).exactly(4).times
			subject.console_io.should_receive(:display_draw).exactly(1).times
			subject.run_game
		end

		it "runs game loop 4 times until game is won" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(4).times
			subject.game_rules.should_receive(:invalid_move?).and_return(false,false,false,false)
			subject.board.should_receive(:place_move).exactly(4).times
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.should_receive(:switch_current_player).exactly(4).times
			subject.game_rules.should_receive(:game_win).and_return("x","x")
			subject.console_io.should_receive(:display_win).exactly(1).times
			subject.run_game
		end		
	end

	context "#switch_current_player" do
		it "sets the current player to player_1" do
			subject.switch_current_player
			subject.current_player.should == subject.player_2
		end

		it "sets the current player to player_2 when called twice" do
			subject.switch_current_player
			subject.switch_current_player
			subject.current_player.should == subject.player_1
		end
	end

end