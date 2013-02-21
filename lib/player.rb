class Player
	attr_reader :piece, :name

	def initialize(piece, name)
		@piece = piece
		@name = name
	end
end