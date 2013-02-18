require 'player'
require 'game_rules'
require 'validations'

class Game
	attr_accessor :game_rules, :console_io, :board, :player_1, :player_2, :current_players, :current_player, :move, :gamepiece

	def initialize(board, console_io)
		@console_io = console_io
		@board = board
		@game_rules = GameRules.new(@board)
		@validations = Validations.new(@board)
	end

	def setup_game
		@player_1 = Player.new(display_and_get_gamepiece)
		@player_2 = Player.new(display_and_get_gamepiece)
		@current_players = [@player_1, @player_2]
		@current_player = @player_1
		display_welcome_message
	end

	def run_game
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

		@game_rules.game_win != "" ? display_win(@game_rules.game_win) : display_draw
	end

	def display_and_get_gamepiece
		@console_io.display_and_get_gamepiece
	end

	def display_welcome_message
		@console_io.display_welcome_message
	end

	def display_gameboard
		@console_io.display_gameboard
	end

	def display_and_get_move
		@move = @console_io.display_and_get_move(@current_player.piece).to_i
	end

	def place_move
		@board.place_move(@current_player.piece, @move)
	end

	def invalid_move?
		@validations.invalid_move?(@move)
	end

	def display_invalid_move
		@console_io.display_invalid_move
	end

	def switch_current_player
		@current_player = @current_players.reverse!.first
	end

	def display_win(player)
		@console_io.display_win(player)
	end

	def display_draw
		@console_io.display_draw
	end
end