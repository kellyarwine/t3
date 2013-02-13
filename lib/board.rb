class Board
	attr_accessor :spaces, :size

	SPACE_LENGTH = 5
	BLANK_SPACE = " "
	GRID_HORIZONTAL_LINE = "-"
	GRID_CROSSHAIRS = "+"
	GRID_VERTICAL_LINE = "|"
	LINE_END = "\n"

	def initialize
		@spaces = Array.new(9)
	end

	def size
		@spaces.count
	end

	def place_move(marker, space)
		@spaces[space-1] = marker
	end

	def construct_gameboard
		gameboard = ""
		gameboard << generate_margin
		gameboard << generate_row(@spaces[0],@spaces[1],@spaces[2])
		gameboard << generate_horizontal_grid
		gameboard << generate_row(@spaces[3],@spaces[4],@spaces[5])
		gameboard << generate_horizontal_grid
		gameboard << generate_row(@spaces[6],@spaces[7],@spaces[8])
		gameboard << generate_margin
	end

	def generate_row(space1,space2,space3)
		"  #{space(space1)}  |  #{space(space2)}  |  #{space(space3)}  " + LINE_END
	end

	def space(space_number)
		space_number.nil? ? BLANK_SPACE : space_number
	end

	def generate_margin
		margin = ""
		margin << BLANK_SPACE * SPACE_LENGTH
		margin << GRID_VERTICAL_LINE
		margin << BLANK_SPACE * SPACE_LENGTH
		margin << GRID_VERTICAL_LINE
		margin << BLANK_SPACE * SPACE_LENGTH
		margin << "\n"
	end

	def generate_horizontal_grid
		grid = ""
		grid << GRID_HORIZONTAL_LINE * SPACE_LENGTH
		grid << GRID_CROSSHAIRS
		grid << GRID_HORIZONTAL_LINE * SPACE_LENGTH
		grid << GRID_CROSSHAIRS
		grid << GRID_HORIZONTAL_LINE * SPACE_LENGTH
		grid << LINE_END
	end

end