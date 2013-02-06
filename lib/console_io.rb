class ConsoleIo
	attr_accessor :input, :output, :gamepiece

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
		display(message)
		input.gets.chomp
	end

	def display_gameboard
		display(@board.construct_gameboard)
	end

	def prompt_for_move
		prompt("Please enter your move (1-9):")
	end

end