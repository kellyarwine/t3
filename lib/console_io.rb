require 'board'

class ConsoleIo
	attr_accessor :input, :output

	def initialize(input = nil, output = nil)
		@input, @output = input, output
		@board = Board.new
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

	def prompt(message)
		output.puts message
		input.gets.chomp
	end

	def display_welcome_message
		display("Welcome to T3!\nGet ready to lose.\n\n")
	end

	def display_empty_gameboard
		display(@board.construct_empty_gameboard)
	end

	def grab_gamepiece
		prompt("Do you want to be x or o?")
	end

	def display_invalid_gamepiece
		display("The gamepiece you chose is invalid. Please try again.")
	end

	def grab_move
		prompt("Enter your move [1-9]:")
	end
# --------------------------------------------------
	def continue_playing?
		output.puts "Do you want to play again? (y/n)"
		input.gets.chomp.upcase == "Y" ? true : false
	end

end