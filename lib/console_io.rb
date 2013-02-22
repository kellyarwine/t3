class ConsoleIo
	attr_accessor :input, :output, :gamepiece, :board_row

	SPACE_LENGTH = 5
	BLANK_SPACE = " "
	GRID_HORIZONTAL_LINE = "-"
	GRID_CROSSHAIRS = "+"
	GRID_VERTICAL_LINE = "|"
	LINE_END = "\n"

	def initialize(input = nil, output = nil)
		@input, @output = input, output
	end
	
	def input
		@input ||= STDIN
	end

	def output
		@output ||= STDOUT
	end

	def display(message)
		output.puts message
	end

	def display_and_get(message)
		display(message)
		input.gets.chomp
	end

	def display_and_get_opponent
		display("Choose your opponent:\n\n")
		display("1. AI Player (Easy)\n")
		display_and_get("2. Human Player\n\n")
	end

	def display_and_get_board
		display("Choose the board size:\n\n")
		display("1. 3x3\n")
		display("2. 4x4\n")
		display_and_get("3. 5x5\n\n")
	end

	def display_invalid_board
		display("Invalid board.  Please try again.")
	end

	def display_and_get_gamepiece(name)
		display_and_get("#{name}, what 1-character symbol would you like for your gamepiece?")
	end

	def display_invalid_gamepiece
		display("Invalid gamepiece.  Please try again.")
	end


	def display_welcome_message
		display("\nWelome to T3!  Get ready to lose.\n\n")
	end

	def display_and_get_move(player, move = nil)
		if player.name == "Human"
			display_and_get("#{player.name}, please enter a move (1-9):")
		else
			display("#{player.name}, please enter a move (1-9):\n#{move}")
			return move
		end
	end

	def display_gameboard(spaces, row_column_size)
		display(construct_gameboard(spaces, row_column_size))
	end

	def construct_gameboard(spaces, row_column_size)
		gameboard = ""
		array_of_rows = spaces.each_slice(row_column_size).to_a
		gameboard << generate_margin(row_column_size)

		array_of_rows.each do |row|
			gameboard << generate_row(row)
			gameboard << generate_grid_row(row_column_size)
		end
		gameboard = gameboard[0..-6*row_column_size-2]
		gameboard << LINE_END
		gameboard << generate_margin(row_column_size)
		gameboard << LINE_END
		gameboard << LINE_END
	end

	def generate_margin(row_column_size)
		margin = ""

		row_column_size.times do
			margin << BLANK_SPACE * SPACE_LENGTH
			margin << GRID_VERTICAL_LINE
		end

		margin = margin[0..-2]
	end

	def generate_row(row)
		generated_row = ""
		generated_row << LINE_END

		row.each do |space|
			generated_row << "  #{"%-2s" % (space)} |"
		end

		generated_row = generated_row[0..-2]
	end

	def generate_grid_row(row_column_size)
		grid_row = ""
		grid_row << LINE_END

		row_column_size.times do
			grid_row << GRID_HORIZONTAL_LINE * SPACE_LENGTH
			grid_row << GRID_CROSSHAIRS
		end

		grid_row = grid_row[0..-2]
	end

	def display_invalid_move
		display("Invalid move.  Please try again.")
	end

	def display_win(name)
		display("#{name} wins!")
	end

	def display_draw
		display("The game is a draw.")
	end

	def display_and_get_play_again
		display_and_get("Would you like to play again?")
	end

end	