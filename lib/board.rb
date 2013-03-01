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

	def invalid_move?(space)
		 (not space_open?(space) && in_board_range?(space) && valid_integer?(space))
	end

	def valid_integer?(space)
		space.to_s =~ /\d/
	end

	def in_board_range?(space)
		space.between?(1,@size) 
	end

	def space_open?(space)
		!!(@spaces[space-1] =~ /\d/)
	end

end