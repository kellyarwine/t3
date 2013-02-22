class Board
	attr_accessor :spaces, :size, :row_column_size

	def initialize(size)
		@size = size
		@spaces = *("1"..@size.to_s)
	end

	def row_column_size 
		Math.sqrt(@size).to_i
	end

	def place_move(gamepiece, space)
		@spaces[space-1] = gamepiece
	end

	def available_spaces
		@spaces.select { |space| space =~ /\d/ }
	end

end