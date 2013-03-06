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

      depth = 0
      score =0
      move_history = Hash.new
      score_hash = Hash.new

      for i in 0..available_spaces.length-1
        # binding.pry
        space = available_spaces[i]
        score_hash[space] = run_scorer(@board.available_spaces,gamepieces,score,depth)
        # result = 0
      end
      score_hash
    end
  
    def run_scorer(available_spaces,gamepieces,score,depth,p1=nil,p2=nil,p3=nil)
      score_hash = Hash.new
      move_history = Hash.new
      result = 0
      for i in 0..available_spaces.length-1

        depth += 1
        position = @board.spaces.index(available_spaces[i])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first
        # binding.pry
        result += run_scorer(@board.available_spaces,gamepieces.reverse,score,depth,move_history,p1,p2) if not @game_rules.game_over?
        result += score_win(score,depth)
        puts "#{result} => #{p3} #{p2} #{p1} #{move_history}"
        # binding.pry
        # space = available_spaces[i]
        # score_hash[space] = result.round(3)
        # binding.pry
   
        unwind_board(move_history)

        move_history = Hash.new
        depth -= 1
      end
        result
    end
  
    def score_win(score,depth)
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
