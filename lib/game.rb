require 'console_io'
require 'board'
require 'player'

class Game
	attr_accessor :move, :board, :console_io, :player_1, :player_2, :current_players, :current_player

	def initialize
		@board = Board.new
		@console_io = ConsoleIo.new(@board)
		@player_1 = Player.new("x")
		@player_2 = Player.new("o")
		@current_players = [@player_1, @player_2]
		@current_player = @player_1
	end

	def run
		display_welcome_message
		@board.size.times do
			display_and_get_move
			until valid_move?
				display_invalid_move
				display_and_get_move
			end
			place_move
			print_board
			switch_current_player
		end
	end

	def display_welcome_message
		@console_io.display_welcome_message
	end

	def print_board
		@console_io.display_gameboard
	end

	def display_and_get_move
		@move = @console_io.display_and_get_move(@current_player.piece)
	end

	def place_move
		@board.place_move(@current_player.piece, @move)
	end

	def valid_move?
		@board.valid_move?(@move)
	end

	def display_invalid_move
		@console_io.display_invalid_move
	end

	def switch_current_player
		@current_player = @current_players.reverse!.first
	end

end