require 'console_io'
require 'board'
require 'player'
require 'game_rules'

class Game
	attr_accessor :game_rules, :console_io, :board, :player_1, :player_2, :current_players, :current_player, :move

	def initialize
		@board = Board.new
		@game_rules = GameRules.new(@board)
		@console_io = ConsoleIo.new(@board)
		@player_1 = Player.new("x")
		@player_2 = Player.new("o")
		@current_players = [@player_1, @player_2]
		@current_player = @player_1
	end

	def run
		display_welcome_message
		until @game_rules.game_over?
			display_and_get_move
			while invalid_move?
				display_invalid_move
				display_and_get_move
			end
			place_move
			display_gameboard
			switch_current_player
		end
	end

	def display_welcome_message
		@console_io.display_welcome_message
	end

	def display_gameboard
		@console_io.display_gameboard
	end

	def display_and_get_move
		@move = @console_io.display_and_get_move(@current_player.piece)
	end

	def place_move
		@board.place_move(@current_player.piece, @move)
	end

	def invalid_move?
		@game_rules.invalid_move?(@move)
	end

	def display_invalid_move
		@console_io.display_invalid_move
	end

	def switch_current_player
		@current_player = @current_players.reverse!.first
	end

end