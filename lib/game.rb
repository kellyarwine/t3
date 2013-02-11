require 'console_io'
require 'board'

class Game
	attr_accessor :move, :board, :console_io, :player_1, :player_2

	def initialize
		@board = Board.new
		@console_io = ConsoleIo.new(@board)
		@player_1 = Player.new("x")
		@player_2 = Player.new("o")
	end

	def run
		@board.size.times do
			display_and_get_move
			until valid_move?
				display_invalid_move
				display_and_get_move
			end
			place_move
			print_board
		end
	end

	def print_board
		@console_io.display_gameboard
	end

	def display_and_get_move
		@move = @console_io.display_and_get_move
	end

	def place_move
		@board.place_move("x", @move)
	end

	def valid_move?
		@board.valid_move?(@move)
	end

	def display_invalid_move
		@console_io.display_invalid_move
	end

	def current_player
		[@player_2, @player_1].reverse!.first
	end

end