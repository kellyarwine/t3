require 'game'

class GameRunner

	def initialize
		game = Game.new
		game.setup_game
	end

end