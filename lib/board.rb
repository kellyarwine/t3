class Board
	attr_accessor :spaces
	SQUARE_LENGTH = 5
	BLANK_SQUARE = " "
	GRID_HORIZONTAL_LINE = "-"
	GRID_CROSSHAIRS = "+"
	GRID_VERTICAL_LINE = "|"
	LINE_END = "\n"

	def initialize
		@spaces = Array.new(9)
	end

	def place_move(marker, square)
		@spaces[square-1] = marker
	end

	def valid_move?(square)
		square <= @spaces.size && @spaces[square-1].nil?
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

	def generate_row(square1,square2,square3)
		square1 = BLANK_SQUARE if square1.nil?
		square2 = BLANK_SQUARE if square2.nil?
		square3 = BLANK_SQUARE if square3.nil?
		"  #{square1}  |  #{square2}  |  #{square3}  " + LINE_END
	end

	def generate_margin
		margin = ""
		margin << BLANK_SQUARE * SQUARE_LENGTH
		margin << GRID_VERTICAL_LINE
		margin << BLANK_SQUARE * SQUARE_LENGTH
		margin << GRID_VERTICAL_LINE
		margin << BLANK_SQUARE * SQUARE_LENGTH
		margin << "\n"
	end

	def generate_horizontal_grid
		grid = ""
		grid << GRID_HORIZONTAL_LINE * SQUARE_LENGTH
		grid << GRID_CROSSHAIRS
		grid << GRID_HORIZONTAL_LINE * SQUARE_LENGTH
		grid << GRID_CROSSHAIRS
		grid << GRID_HORIZONTAL_LINE * SQUARE_LENGTH
		grid << LINE_END
	end

end