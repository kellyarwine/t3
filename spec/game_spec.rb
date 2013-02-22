require 'spec_helper'

describe Game do
	let(:console_io)				{ ConsoleIo.new									}
	let(:player_1)					{ Player.new("x", "Player 1")		}
	let(:player_2)					{ Player.new("o", "Player 2")		}
	let(:subject)						{ Game.new(console_io)					}

	# context "#setup_game" do
		# xit "sets up correctly" do
		# 	subject.should_receive(:board_size).and_return(16)
		# 	subject.board.should be_kind_of(Board)
		# 	subject.game_rules.should_receive(:new)
		# 	subject.configurations.should_receive(:new)
		# 	subject.should_receive(:setup_players)
		# 	subject.console_io.should_receive(:display_welcome_message).exactly(1).times

		# 	# subject.board.should be_kind_of(Board)
		# 	# subject.game_rules.should be_kind_of(GameRules)
		# 	# subject.configurations.should be_kind_of(Configurations)
		# 	# subject.player_1.piece.should == "Q"
		# 	# subject.player_2.piece.should == "V"
		# 	# subject.players = ["Q", "V"]
		# 	# subject.current_player = "Q"
			
		# 	subject.setup_game
			
		# 	# subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
		# 	# subject.console_io.should_receive(:display_and_get_gamepiece).and_return("Q", "V")
		# 	# subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)
		# 	# subject.console_io.should_receive(:display_invalid_gamepiece).exactly(0).times
		# 	# subject.console_io.should_receive(:display_welcome_message).exactly(1).times
		# end

		# it "sets up correctly with an invalid gamepiece input for each player" do
		# 	subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
		# 	subject.console_io.should_receive(:display_and_get_gamepiece).and_return("QR", "Q", "VR", "V")
		# 	subject.configurations.should_receive(:invalid_gamepiece?).and_return(true,false,true,false)
		# 	subject.console_io.should_receive(:display_invalid_gamepiece).exactly(2).times
		# 	subject.console_io.should_receive(:display_welcome_message).exactly(1).times
		# 	subject.setup_game
		# 	subject.player_1.piece.should == "Q"
		# 	subject.player_2.piece.should == "V"
		# end
	# end

	# context "#run_game" do
	# 	it "runs game loop once with no invalid moves then game is a draw" do
	# 		subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
	# 		subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x", "o")
	# 		subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)
	# 		subject.console_io.should_receive(:display_welcome_message).exactly(1).times
	# 		subject.game_rules.should_receive(:game_over?).and_return(false, true)
	# 		subject.console_io.should_receive(:display_and_get_move).exactly(1).times
	# 		subject.game_rules.should_receive(:invalid_move?).and_return(false)
	# 		subject.board.should_receive(:place_move).exactly(1).times
	# 		subject.console_io.should_receive(:display_gameboard).exactly(1).times
	# 		#this method mocks itself
	# 		subject.should_receive(:switch_current_player).exactly(1).times
	# 		subject.console_io.should_receive(:display_draw).exactly(1).times			
	# 		subject.setup_game
	# 		subject.run_game
	# 	end

		# it "runs game loop once with 1 invalid move then game is a draw" do
		# 	subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
		# 	subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x", "o")			
		# 	subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)			
		# 	subject.console_io.should_receive(:display_welcome_message).exactly(1).times
		# 	subject.game_rules.should_receive(:game_over?).and_return(false,true)
		# 	subject.console_io.should_receive(:display_and_get_move).exactly(2).times
		# 	subject.game_rules.should_receive(:invalid_move?).and_return(true,false)
		# 	subject.console_io.should_receive(:display_invalid_move).exactly(1).times
		# 	subject.board.should_receive(:place_move).exactly(1).times
		# 	subject.console_io.should_receive(:display_gameboard).exactly(1).times
		# 	#this method mocks itself
		# 	subject.should_receive(:switch_current_player).exactly(1).times
		# 	subject.console_io.should_receive(:display_draw).exactly(1).times
		# 	subject.setup_game
		# 	subject.run_game
		# end

		# it "runs game loop 4 times with 2 invalid moves then game is a draw" do
		# 	subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
		# 	subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x", "o")
		# 	subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)
		# 	subject.console_io.should_receive(:display_welcome_message).exactly(1).times
		# 	subject.game_rules.should_receive(:game_over?).and_return(false,false,false,false,true)
		# 	subject.console_io.should_receive(:display_and_get_move).exactly(6).times
		# 	subject.game_rules.should_receive(:invalid_move?).and_return(true,false,false,true,false,false)
		# 	subject.console_io.should_receive(:display_invalid_move).exactly(2).times
		# 	subject.board.should_receive(:place_move).exactly(4).times
		# 	subject.console_io.should_receive(:display_gameboard).exactly(4).times
		# 	#this method mocks itself
		# 	subject.should_receive(:switch_current_player).exactly(4).times
		# 	subject.console_io.should_receive(:display_draw).exactly(1).times
		# 	subject.setup_game
		# 	subject.run_game
		# end

		# it "runs game loop 4 times then game is won" do
		# 	subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
		# 	subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x", "o")
		# 	subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)			
		# 	subject.console_io.should_receive(:display_welcome_message).exactly(1).times
		# 	subject.game_rules.should_receive(:game_over?).and_return(false,false,false,false,true)
		# 	subject.console_io.should_receive(:display_and_get_move).exactly(4).times
		# 	subject.game_rules.should_receive(:invalid_move?).and_return(false,false,false,false)
		# 	subject.board.should_receive(:place_move).exactly(4).times
		# 	subject.console_io.should_receive(:display_gameboard).exactly(4).times
		# 	#this method mocks itself
		# 	subject.should_receive(:switch_current_player).exactly(4).times
		# 	subject.game_rules.should_receive(:winning_gamepiece).and_return("x","x")
		# 	subject.console_io.should_receive(:display_win).exactly(1).times
		# 	subject.setup_game
		# 	subject.run_game
		# end
	# end

	# context "#switch_current_player" do
	# 	it "sets the current player to player_1" do
	# 		subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
	# 		subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x", "o")
	# 		subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)
	# 		subject.console_io.should_receive(:display_welcome_message).exactly(1).times			
	# 		subject.setup_game
	# 		subject.switch_current_player
	# 		subject.current_player.should == subject.player_2
	# 	end

	# 	it "sets the current player to player_2 when called twice" do
	# 		subject.console_io.should_receive(:display_and_get_board).and_return("3x3")
	# 		subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x", "o")
	# 		subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)
	# 		subject.console_io.should_receive(:display_welcome_message).exactly(1).times			
	# 		subject.setup_game
	# 		subject.switch_current_player
	# 		subject.switch_current_player
	# 		subject.current_player.should == subject.player_1
	# 	end
	# end

	# it "sets the board to the appropriate size" do
	# 	subject.console_io.should_receive(:display_and_get_board).and_return("4x4")
	# 	subject.board_size.should == 16
	# end	

	# it "sets up 2 players with customized gamepieces" do
	# 	subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x","o")
	# 	subject.configurations.should_receive(:invalid_gamepiece?).and_return(false,false)
	# 	subject.setup_players
	# 	subject.player_1.piece.should == "x"
	# 	subject.player_2.piece.should == "o"
	# end	

	# context "#create_player" do
	# 	it "sets up a player when gamepiece input is valid" do
	# 		subject.console_io.should_receive(:display_and_get_gamepiece).and_return("x")
	# 		subject.configurations.should_receive(:invalid_gamepiece?).and_return(false)
	# 		subject.create_player("Player 1").should be_kind_of(Player)
	# 	end	

	# 	it "sets up a player when gamepiece input is invalid 2 times" do
	# 		subject.console_io.should_receive(:display_and_get_gamepiece).and_return("xr","xy","o")
	# 		subject.configurations.should_receive(:invalid_gamepiece?).and_return(true,true,false)
	# 		subject.console_io.should_receive(:display_invalid_gamepiece).exactly(2).times
	# 		subject.create_player("Player 1").should be_kind_of(Player)
	# 	end	
	# end

	it "sets up the turn order so that player_1 goes first" do
		subject.players = [player_1, player_2]
		subject.console_io.should_receive(:display_and_get_turn_order).and_return("1")
		subject.get_turn_order.should == [player_1,player_2]
	end

	it "sets up the turn order so that player_2 goes first" do
		subject.players = [player_1, player_2]
		subject.console_io.should_receive(:display_and_get_turn_order).and_return("2")
		subject.get_turn_order.should == [player_2,player_1]
	end

end