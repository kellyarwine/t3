require 'Player'

class EasyAi < Player
	
	def initialize(piece)
		super(piece)
	end

	def human?
		false
	end

	def get_move(available_spaces)
		available_spaces.sample.to_i
	end

end