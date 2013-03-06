module T3
  class Minimax
    attr_accessor :board, :game_rules, :console_io
  
    def initialize(board,game_rules,console_io)
      @board = board
      @game_rules = game_rules
      @console_io = console_io
    end
  
    def feed_scorer(available_spaces,gamepieces,score)
      require 'pry'
      require 'pry-debugger'  

      score_hash = Hash.new

      available_spaces.each_with_index do |available_space,i|
        # binding.pry
        space = available_spaces[i]
        score_hash[space] = run_scorer(@board.available_spaces,gamepieces)
      end
      score_hash
    end
  
    def run_scorer(available_spaces,gamepieces,depth=0,p1=nil,p2=nil,p3=nil)
      score_hash = Hash.new
      result = 0

      available_spaces.each_with_index do |available_space, i|
        move_history = Hash.new
        depth += 1
        position = @board.spaces.index(available_spaces[i])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first

        result += run_scorer(@board.available_spaces,gamepieces.reverse,depth,move_history,p1,p2) if not @game_rules.game_over?
        
        result += score_win(depth)
        
        space = available_spaces[i]
        score_hash[space] = result
        
        puts "History:     #{result} => #{p3} #{p2} #{p1} #{move_history}"
        puts "Score Hash:  #{result} => #{score_hash}"
        # binding.pry if space == "6" || space == "7"
   
        unwind_board(move_history)

        # move_history = Hash.new
        depth -= 1
      end
        result
    end
  
    def score_win(depth)
      case @game_rules.winning_gamepiece
      when nil then 0.0
      when "o" then 1.0/depth
      else
        -1.0/depth
      end
    end
  
    def unwind_board(move_history)
      move_history.keys.each { |key| @board.spaces[key-1] = key.to_s }
    end
  end
end
