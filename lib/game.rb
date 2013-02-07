require 'console_io'
require 'board'
require 'pry'

class Game
	attr_accessor :move, :board, :console_io

	def initialize
		@board = Board.new
		@console_io = ConsoleIo.new(@board)
	end

	def run
		for i in 1..9
			prompt_for_move
			place_move
			print_board
		end
	end

	def print_board
		@console_io.display_gameboard
	end

	def prompt_for_move
		@move = @console_io.prompt_for_move
	end

	def place_move
		@board.place_move("x", @move.to_i)
	end

end