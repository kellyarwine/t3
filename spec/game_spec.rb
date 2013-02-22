require 'spec_helper'

describe Game do
	let(:console_io)	{ ConsoleIo.new								}
	let(:player_1)		{ Player.new("x", "Player 1")	}
	let(:player_2)		{ Player.new("o", "Player 2")	}
	let(:subject)			{ Game.new(console_io)				}
	let(:players)			{ [player_1, player_2]				}

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

	context "#get_board_size" do
		it "sets up a 3x3 board" do
			subject.console_io.should_receive(:display_and_get_board).and_return("1")
			subject.get_board_size.should == 9
		end	

		it "sets up a 4x4 board" do
			subject.console_io.should_receive(:display_and_get_board).and_return("2")
			subject.get_board_size.should == 16
		end	

		it "sets up a 5x5 board" do
			subject.console_io.should_receive(:display_and_get_board).and_return("3")
			subject.get_board_size.should == 25
		end	

		it "sets up a 5x5 board after an invalid selection is made" do
			subject.console_io.should_receive(:display_and_get_board).and_return("100","3")
			subject.console_io.should_receive(:display_invalid_selection)
			subject.get_board_size.should == 25
		end			
	end

	context "#get_human_gamepiece" do
		it "sets up a gamepiece for a human" do
			subject.console_io.should_receive(:display_and_get_gamepiece).and_return("Z")
			subject.configurations.should_receive(:invalid_gamepiece?).and_return(false)
			subject.get_human_gamepiece("Human").should == "z"
		end	

		it "sets up a gamepiece for the AI" do
			subject.get_ai_gamepiece.should == "x"
		end	

		it "sets up a gamepiece for a human after an invalid selection is made" do
			subject.console_io.should_receive(:display_and_get_gamepiece).and_return("10","Z")
			subject.console_io.should_receive(:display_invalid_selection)
			subject.get_human_gamepiece("Human").should == "z"
		end	
	end

	context "#get_opponent" do
		it "sets up a player when one player is the AI" do
			subject.console_io.should_receive(:display_and_get_opponent).and_return("1")
			subject.get_opponent.should be_kind_of(EasyAi)
		end	

		it "sets up a player when one player is the human" do
			subject.console_io.should_receive(:display_and_get_opponent).and_return("2")
			subject.console_io.should_receive(:display_and_get_gamepiece).and_return("u")
			subject.get_opponent.should be_kind_of(Human)
		end	

		it "sets up an AI player after an invalid selection is made" do
			subject.console_io.should_receive(:display_and_get_opponent).and_return("gg","1")
			subject.console_io.should_receive(:display_invalid_selection)
			subject.get_opponent.should be_kind_of(EasyAi)
		end	
	end

	context "#get_turn_order" do
		it "sets up player_1 as the first player" do
			subject.players = [player_1, player_2]
			subject.console_io.should_receive(:display_and_get_turn_order).and_return("1")
			subject.get_turn_order.should == [player_1,player_2]
		end

		it "sets up player_2 as the first player" do
			subject.players = [player_1, player_2]
			subject.console_io.should_receive(:display_and_get_turn_order).and_return("2")
			subject.get_turn_order.should == [player_2,player_1]
		end

		it "sets up player_2 as the first player after an invalid selection is made" do
			subject.players = [player_1, player_2]
			subject.console_io.should_receive(:display_and_get_turn_order).and_return("4","2")
			subject.console_io.should_receive(:display_invalid_selection)
			subject.get_turn_order.should == [player_2,player_1]
		end
	end

	context "#get_player_name" do
		it "returns the player name when given a gamepiece" do
			subject.players = [player_1, player_2]
			subject.get_player_name("x").should == player_1.name
		end

		it "returns the player name when given a gamepiece" do
			subject.players = [player_1, player_2]
			subject.get_player_name("o").should == player_2.name
		end
	end
end