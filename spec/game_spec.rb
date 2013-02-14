require 'spec_helper'

describe Game do
	let(:board) 						{ double('Board')				}
	let(:game_rules)				{ double('GameRules')		}
	let(:console_io)				{ double('ConsoleIo')		}

	context "#initialize" do
		it "creates an instance of GameRules" do
			subject.game_rules.should be_kind_of(GameRules)
		end

		it "creates an instance of Board" do
			subject.board.should be_kind_of(Board)
		end

		it "creates an instance of ConsoleIo" do
			subject.console_io.should be_kind_of(ConsoleIo)
		end

		it "creates an instance of player" do
			subject.player_1.should be_kind_of(Player)
		end

		it "creates an second instance of player" do
			subject.player_2.should be_kind_of(Player)
		end

		it "creates a instance of current_players with two players" do
			subject.current_players.should == [subject.player_1,subject.player_2]
		end

		it "sets player 1 as the first player" do
			subject.current_player.should == subject.player_1
		end
	end

	context "#run" do
		it "runs game loop once with move that's not invalid" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(1).times
			subject.game_rules.should_receive(:invalid_move?).and_return(false)
			subject.board.should_receive(:place_move).exactly(1).times
			subject.console_io.should_receive(:display_gameboard).exactly(1).times
			subject.should_receive(:switch_current_player).exactly(1).times
			subject.run
		end

		it "runs game loop once with 1 invalid input" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(2).times
			subject.game_rules.should_receive(:invalid_move?).and_return(true, false)
			subject.console_io.should_receive(:display_invalid_move).exactly(1).times
			subject.board.should_receive(:place_move).exactly(1).times
			subject.console_io.should_receive(:display_gameboard).exactly(1).times
			subject.should_receive(:switch_current_player).exactly(1).times
			subject.run
		end

		it "runs game loop 4 times with 2 invalid inputs" do
			subject.console_io.should_receive(:display_welcome_message).exactly(1).times
			subject.game_rules.should_receive(:game_over?).and_return(false,false,false,false,true)
			subject.console_io.should_receive(:display_and_get_move).exactly(6).times
			subject.game_rules.should_receive(:invalid_move?).and_return(true,false,false,true,false,false)
			subject.console_io.should_receive(:display_invalid_move).exactly(2).times
			subject.board.should_receive(:place_move).exactly(4).times
			subject.console_io.should_receive(:display_gameboard).exactly(4).times
			subject.should_receive(:switch_current_player).exactly(4).times
			subject.run
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