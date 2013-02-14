class GameRules
	attr_accessor :board

	STARTING_SPACE = 0
	
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

	def game_win?
		# rows.map { |group| group.select { |space| space == "x" } }
		# @board.spaces.select { |space| space == nil }.empty?
	end

	def rows
		@board.spaces.each_slice(@board.row_column_size).to_a
	end

	def columns
		rows.transpose
	end

	def left_diagonal
		range_start = STARTING_SPACE
		range_end = @board.row_column_size - 1
		range = range_start..range_end
		[ range.collect{ |i| rows[i][i] } ]
	end

	def right_diagonal
		range_start = STARTING_SPACE
		range_end = @board.row_column_size - 1
		range = range_start..range_end
		inverted_rows = rows.map { |row| row.reverse }
		[ range.collect { |i| inverted_rows.reverse[i][i] } ]
	end


end