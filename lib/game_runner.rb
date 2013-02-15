require 'game'
# require 'console_io'

class GameRunner
	# attr_accessor :game, :console_io

	def initialize
		# @board = Board.new
		# @console_io = ConsoleIo.new(@board)
	end

	def play_game
		Game.new.run
		# play_game if display_and_get_play_again == "Y"
	end

	# def display_and_get_play_again
	# 	@console_io.display_and_get_play_again
	# end

end