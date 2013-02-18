class GameRules
	attr_accessor :board
	
	STARTING_SPACE = 0
	
	def initialize(board)
		@board = board
	end

	def game_over?
		@board.spaces.select { |space| space == nil }.empty? || game_win != ""
	end

	def game_win
		groups = [row_contents, column_contents, left_diagonal_contents, right_diagonal_contents]
		winner = ""

		groups.map do |group|
			if group.any? { |set| set == ["x","x","x"] }
				winner << "x"
			elsif group.any? { |set| set == ["o","o","o"] }
				winner << "o"
			end
		
		end
		winner
	end

	def row_contents
		@board.spaces.each_slice(@board.row_column_size).to_a
	end

	def column_contents
		row_contents.transpose
	end

	def left_diagonal_contents
		[ range.collect{ |i| row_contents[i][i] } ]
	end

	def right_diagonal_contents
		reversed_row_contents = row_contents.map { |row| row.reverse }
		[ range.collect { |i| reversed_row_contents[i][i] } ]
	end

	private 

	def range
		range_start = STARTING_SPACE
		range_end = @board.row_column_size - 1
		range = range_start..range_end
	end

end