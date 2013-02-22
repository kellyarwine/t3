require 'Player'

class EasyAi < Player
	
	def initialize(piece,name)
		super(piece,name)
	end

	def get_move(available_spaces)
		available_spaces.sample.to_i
	end

end