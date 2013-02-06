require 'pry'

class Board
	attr_accessor :spaces

	def initialize
		@spaces = Array.new(9)
	end

	def place_move(marker, square)
		@spaces[square-1] = marker
	end

	def construct_gameboard
		gameboard = ""
		gameboard << generate_gameboard_margin
		gameboard << generate_gameboard_row(@spaces[0],@spaces[1],@spaces[2])
		gameboard << generate_gameboard_horizontal_grid
		gameboard << generate_gameboard_row(@spaces[3],@spaces[4],@spaces[5])
		gameboard << generate_gameboard_horizontal_grid
		gameboard << generate_gameboard_row(@spaces[6],@spaces[7],@spaces[8])
		gameboard << generate_gameboard_margin
	end

	def generate_gameboard_row(square1,square2,square3)
		square1 = " " if square1.nil?
		square2 = " " if square3.nil?
		square3 = " " if square2.nil?
		"  #{square1}  |  #{square2}  |  #{square3}  \n"
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