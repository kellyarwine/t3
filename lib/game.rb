require 'console_io'
require 'board'
require 'pry'

class Game
	attr_accessor :move

	def initialize
		@console_io = ConsoleIo.new
		@board = Board.new
	end

	def run
		prompt_for_move
		place_move
		print_board
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