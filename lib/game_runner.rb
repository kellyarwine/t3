require 'game'
require 'console_io'
require 'board'

class GameRunner
	attr_accessor :console_io, :game

	def initialize
		@board = Board.new
		@console_io = ConsoleIo.new(@board)
		@game = Game.new(@board, @console_io)
	end

	def play_game
		while play_again?
			@game.setup_game
			@game.run_game
		end
	end

	def play_again?
		@console_io.display_and_get_play_again.upcase == "Y"
	end

end