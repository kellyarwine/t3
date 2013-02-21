class Configurations
	attr_accessor :gamepieces

	def initialize
		@gamepieces = []
	end

	def invalid_gamepiece?(gamepiece)
		 (not one_character?(gamepiece)) || duplicate_gamepiece?(gamepiece)
	end

	def store_gamepiece(gamepiece)
		@gamepieces << gamepiece
		@gamepieces
	end

	def duplicate_gamepiece?(gamepiece)
		if not gamepieces.include? gamepiece
			store_gamepiece(gamepiece)
			false
		else
			true
		end
	end

	def one_character?(gamepiece)
		gamepiece.length == 1
	end

	def invalid_board_size?(board_size)
		not board_size =~ /^[1-3]$/
	end


end