require 'game_rules'
require 'configurations'
require 'player'
require 'easy_ai'
require 'human'

class Game
	attr_accessor :game_rules, :console_io, :board, :player_1, :player_2, :players, :current_player, :move, :gamepiece, :configurations

	def initialize(console_io)
		@configurations = Configurations.new
		@console_io = console_io
	end

	def setup_game
		setup_board
		setup_players
		setup_turn_order
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
		display_gameboard
		win_game? ? display_win : display_draw
	end

	def display_invalid_selection
		@console_io.display_invalid_selection
	end

	def setup_board
		@board = Board.new(get_board_size)
		@game_rules = GameRules.new(@board)
	end

	def get_board_size
		case @console_io.display_and_get_board
		when "1" then 9
		when "2" then 16
		when "3" then 25			
		else
			@console_io.display_invalid_selection
			get_board_size
		end
	end

	def setup_players
		@player_1 = Player.new(get_human_gamepiece("Human"), "Human")
		@player_2 = get_opponent
		@players = [@player_1, @player_2]
	end

	def get_opponent
		case @console_io.display_and_get_opponent
		when "1" then EasyAi.new(get_ai_gamepiece, "Easy AI")
		when "2" then Human.new(get_human_gamepiece("Other Human"), "Other Human")
		else
			@console_io.display_invalid_selection
			get_opponent
		end
	end

	def get_human_gamepiece(name)
		gamepiece = @console_io.display_and_get_gamepiece(name).downcase
		if @configurations.invalid_gamepiece?(gamepiece)
			@console_io.display_invalid_selection
			get_human_gamepiece(name)
		else
			gamepiece
		end
	end

	def get_ai_gamepiece
		gamepiece = "x"
		if @configurations.invalid_gamepiece?(gamepiece)
			@console_io.display_invalid_selection
			get_gamepiece(name)
		else
			gamepiece
		end
	end

	def setup_turn_order
		@players = get_turn_order
		@current_player = @players.first
	end

	def get_turn_order
		case @console_io.display_and_get_turn_order(@players)
		when "1" then [@players.first, @players.last]
		when "2" then [@players.last, @players.first]
		else
			@console_io.display_invalid_selection
			get_turn_order
		end
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
		if @current_player.name == "Human"
			@move = @console_io.display_and_get_move(@current_player).to_i
		else
			@move = @current_player.get_move(@board.available_spaces)
			@console_io.display_and_get_move(@current_player,@move).to_i
		end
	end

	def place_move
		@board.place_move(@current_player.piece, @move)
	end

	def invalid_move?
		@game_rules.invalid_move?(@move)
	end

	def switch_current_player
		@current_player = @players.reverse!.first
	end

	def win_game?
		@game_rules.win_game?
	end

	def display_win
		player_name = get_player_name(@game_rules.winning_gamepiece)
		@console_io.display_win(player_name)
	end

	def get_player_name(gamepiece)
		player_name = ""
		@players.map { |player| player_name = player.name if player.piece == gamepiece }
		player_name
	end

	def display_draw
		@console_io.display_draw
	end
end