class Minimax
# 	attr_accessor :board, :game_rules, :console_io, :starting_move, :players, :current_gamepiece, :move_history

# 	def initialize(board,game_rules,console_io)
# 		@board = board
# 		@game_rules = game_rules
# 		@console_io = console_io
# 		@starting_move_and_score = Hash.new [ 0 ]
# 		@gamepieces = ["o","x"]
# 	end

# 	def swap_current_gamepiece
# 		@current_gamepiece = @gamepieces.reverse!.first
# 	end

# 	def start_scorer(available_spaces)
# 		print @board.spaces
# 		puts "\n----------------------------------------------\n"
# 		run_scorer(available_spaces)		
# 	end

# 	def run_scorer(available_spaces)
# require 'pry'
# 		move_history = Hash.new
# 		for i in 1..available_spaces.length
# # binding.pry
# 			@score = 0
      
# 			position = @board.spaces.index(@board.available_spaces[i-1])
# 			@board.spaces[position] = swap_current_gamepiece

# 			move_history[position+1] = @current_gamepiece

# 			print move_history
# 			print "\n"
# 			print @board.spaces
# 			print "\n"

# 			run_scorer(@board.available_spaces) if not @game_rules.game_over?
# # binding.pry
# 		score_win
    
# 		puts "----------------------------------------------\n"
# 		print @board.spaces		
# 		puts "#{@game_rules.winning_gamepiece} wins!"
# 		puts "----------------------------------------------\n"

# 		reset_board_and_counters(move_history)
# 		move_history = Hash.new
# 		end

# 	end

# 	def display_gameboard
# 		@console_io.display_gameboard(@board.spaces,3)
# 	end

# 	def score_win
# 		@game_rules.win_game? == false ? @score -= 1 : @score -= 0
# 		@game_rules.winning_gamepiece == "x" ? @score += 1 : @score -= 1
# 	end

# 	def reset_board_and_counters(move_history)
# 		move_history.keys.each do |key|
# 			board_space_value = (key).to_s
# 			@board.spaces[key-1] = board_space_value
# 		end

# 		@gamepieces = ["o","x"]
# 		@starting_move_and_score[move_history.keys.first] = @score
# 	end
end