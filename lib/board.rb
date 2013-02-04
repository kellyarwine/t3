class Board

	def initialize
		@board = [1,2,3,4,5,6,7,8,9]
	end

	def construct_empty_gameboard
		gameboard = ""
		gameboard << generate_gameboard_margin
		gameboard << generate_gameboard_row(0,1,2)
		gameboard << generate_gameboard_horizontal_grid
		gameboard << generate_gameboard_row(3,4,5)
		gameboard << generate_gameboard_horizontal_grid
		gameboard << generate_gameboard_row(6,7,8)
		gameboard << generate_gameboard_margin
	end

	def generate_gameboard_margin
		margin = ""
		margin << " "* 5
		margin << grid_vertical_line
		margin << " "* 5
		margin << grid_vertical_line
		margin << " "* 5
		margin << "\n"
	end

	def generate_gameboard_horizontal_grid
		grid = ""
		grid << grid_horizontal_line
		grid << grid_crosshairs
		grid << grid_horizontal_line
		grid << grid_crosshairs
		grid << grid_horizontal_line
		grid << "\n"
	end

	def generate_gameboard_row(square1,square2,square3)
		row = ""
		row << generate_gameboard_square(square1)
		row << grid_vertical_line
		row << generate_gameboard_square(square2)
		row << grid_vertical_line
		row << generate_gameboard_square(square3)
		row << "\n"
	end

	def generate_gameboard_square(square)
		" "*2 + @board[square].to_s + " "*2
	end

	def grid_horizontal_line
		"-"*5
	end

	def grid_crosshairs
		"+"
	end

	def grid_vertical_line
		"|"
	end

end