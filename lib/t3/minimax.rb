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
      # binding.pry
      move_history = Hash.new
      score_hash = Hash.new
      depth = 0
      result = 0
      for i in 0..available_spaces.length-1
        # binding.pry
        depth += 1
        position = @board.spaces.index(available_spaces[i])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first
        
        result = run_scorer(available_spaces-[available_spaces[i]],gamepieces.reverse,score,depth,move_history) if not @game_rules.game_over?
        
        # binding.pry
        result += score_win(score,depth)
        space = available_spaces[i]
        score_hash[space] = result.round(3)
        # score_array << result.round(3)
          if @game_rules.win_game?
            puts "----------------------------------------------\n"
          print move_history
          print "\n"          
            print "#{result}"
            print "\n"
            puts "#{@game_rules.winning_gamepiece} wins!\n"
            puts "----------------------------------------------\n"
          end
   
        reset_board_and_counters(move_history)
        move_history = Hash.new
        result = 0
        depth -= 1
      end
      score_hash
    end
  
    def run_scorer(available_spaces,gamepieces,score,depth,p1 = nil,p2 = nil,p3 = nil)
      move_history = Hash.new
      result = 0
      for i in 0..available_spaces.length-1
        # binding.pry
        depth += 1
        position = @board.spaces.index(available_spaces[i])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first
        

        # puts "----------------------------------------------\n"  
        # print "for #{i} in 0..#{available_spaces.length-1}"
        # print "\n"
        # if p3
        #   print "#{p3}"
        #   print "\n"
        # end
        # if p2
        #   print "#{p2}"
        #   print "\n"
        # end
        # if p1
        #   print "#{p1}"
        #   print "\n"
        # end
        # print move_history
        # print "\n"
        # print @board.spaces
        # print "\n"
        
      # binding.pry
        
        result += run_scorer(@board.available_spaces,gamepieces.reverse,score,depth,move_history,p1,p2) if not @game_rules.game_over?


        # binding.pry
        result += score_win(score,depth)
        if @game_rules.win_game?
          puts "----------------------------------------------\n"
        if p3
          print "#{p3}"
          print "\n"
        end
        if p2
          print "#{p2}"
          print "\n"
        end
        if p1
          print "#{p1}"
          print "\n"
        end
        print move_history
        print "\n"          
          print "#{result}"
          print "\n"
          puts "#{@game_rules.winning_gamepiece} wins!\n"
          puts "----------------------------------------------\n"
        end

        reset_board_and_counters(move_history)
        # binding.pry
        move_history = Hash.new
        depth -= 1
      end
        result
    end
  
    def score_win(score,depth)
      # binding.pry
      if @game_rules.win_game? == false
        score += 0.0
      elsif @game_rules.winning_gamepiece == "o"
        score += 1.0
        score/depth
      else
        score -= 1.0
        score/depth
      end
    end
  
    def reset_board_and_counters(move_history)
      # binding.pry
      move_history.keys.each do |key|
        board_space_value = (key).to_s
        @board.spaces[key-1] = board_space_value
      end
    end
  end
end
