require 'console_io'

class Game

	def initialize
	@console_io = ConsoleIo.new
	end

	def setup_game
		@console_io.display_welcome_message
		@console_io.display_empty_gameboard
		until valid_gamepiece?
			@console_io.display_invalid_gamepiece
		end

	end

	def valid_gamepiece?
		["x","o"].include? @console_io.grab_gamepiece
	end

end