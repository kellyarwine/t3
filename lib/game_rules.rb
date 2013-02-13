class GameRules
	attr_accessor :board

	def initialize(board)
		@board = board
	end

	def invalid_move?(space)
		 not input_valid_integer?(space) && space_open?(space)
	end

	def input_valid_integer?(space)
		!!(space.to_s =~ /^[1-9]$/)
	end

	def space_open?(space)
		@board.spaces[space-1].nil?
	end

	def game_over?
		@board.spaces.select { |space| space == nil }.empty?
	end

end