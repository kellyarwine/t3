class ConsoleIo
	attr_accessor :input, :output, :gamepiece

	def initialize(board, input = nil, output = nil)
		@board = board
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

	def display_welcome_message
		display("\nWelome to T3!  Get ready to lose.\n\n")
	end

	def display_gameboard
		display(@board.construct_gameboard)
	end
	
	def display_and_get_move(player_piece)
		player_piece == "x" ? display_and_get("Player 1, please enter a move (1-9):") : display_and_get("Player 2, please enter a move (1-9):")
	end

	def display_invalid_move
		display("Invalid move.  Please try again.")
	end

	def display_win(player_piece)
		display("#{player_piece} wins!")
	end

	def display_draw
		display("The game is a draw.")
	end

	def display_and_get_play_again
		display_and_get("Would you like to play again?")
	end

	def display_and_get_gamepiece
		display_and_get("What 1-character symbol would you like for your gamepiece?")
	end

end	