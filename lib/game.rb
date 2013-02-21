require 'player'
require 'game_rules'
require 'configurations'

class Game
	attr_accessor :game_rules, :console_io, :board, :player_1, :player_2, :players, :current_player, :move, :gamepiece, :configurations, :size

	def initialize(console_io)
		@configurations = Configurations.new
		@console_io = console_io
	end

	def setup_game
		setup_board
		setup_players
		display_welcome_message
	end

	def run_game
		until game_over?
			display_gameboard
			display_and_get_move
			while invalid_move?
				display_invalid_move
				display_and_get_move
			end
			place_move
			switch_current_player
		end
		@game_rules.winning_gamepiece != nil ? display_win(@game_rules.winning_gamepiece) : display_draw
	end

	def setup_board
		@board = Board.new(get_board_size)
		require 'pry'
		binding.pry
		@game_rules = GameRules.new(@board)
	end

	def get_board_size
		board_size = @console_io.display_and_get_board

		if @configurations.invalid_board_size?(board_size)
			@console_io.display_invalid_board
			get_board_size
		end

		if board_size == "1"
			9
		elsif board_size == "2"
			16
		elsif board_size == "3"
			25
		end
	end

	def setup_players
		@player_1 = Player.new(get_gamepiece("Player 1"), "Player 1")
		@player_2 = Player.new(get_gamepiece("Player 2"), "Player 2")
		@players = [@player_1, @player_2]
		@current_player = @players.first
	end

	def get_gamepiece(name)
		gamepiece = @console_io.display_and_get_gamepiece(name)

		if @configurations.invalid_gamepiece?(gamepiece)
			display_invalid_gamepiece
			get_gamepiece(name)
		else 
			gamepiece
		end
	end

	def display_invalid_gamepiece
		@console_io.display_invalid_gamepiece
	end

	def display_welcome_message
		@console_io.display_welcome_message
	end

	def game_over?
		@game_rules.game_over?
	end

	def display_gameboard
		@console_io.display_gameboard(@board.spaces, @board.row_column_size)
	end

	def display_and_get_move
		@move = @console_io.display_and_get_move(@current_player).to_i
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
		@current_player = @players.reverse!.first
	end

	def display_win(player)
		@console_io.display_win(player)
	end

	def display_draw
		@console_io.display_draw
	end
end