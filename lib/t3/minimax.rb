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
      move_history = Hash.new
      score_array = Array.new
      for i in 0..available_spaces.length-1
        # binding.pry
        position = @board.spaces.index(available_spaces[i])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first
        # binding.pry
        score_array << run_scorer(available_spaces-[available_spaces[i]],gamepieces.reverse,score,move_history)
   
        reset_board_and_counters(move_history)
        move_history = Hash.new

      end
      print "This is the passed score: #{score_array}"
      score_array
    end
  
    def run_scorer(available_spaces,gamepieces,score,p1 = nil,p2 = nil,p3 = nil)

      move_history = Hash.new

      for i in 0..available_spaces.length-1
        position = @board.spaces.index(available_spaces[i])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first
        

        puts "----------------------------------------------\n"  
        print "for #{i} in 0..#{available_spaces.length-1}"
        print "\n"
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
        print @board.spaces
        print "\n"
        
        score = run_scorer(@board.available_spaces,gamepieces.reverse,score,move_history,p1,p2) if not @game_rules.game_over?
        # binding.pry
        score = score_win(score)
        # binding.pry
        if @game_rules.win_game?
          puts "----------------------------------------------\n"
          print "#{score}"
          print "\n"
          puts "#{@game_rules.winning_gamepiece} wins!\n"
          puts "----------------------------------------------\n"
        end

        reset_board_and_counters(move_history)
      end
        score
    end
  
    def score_win(score)
      if @game_rules.win_game? == false
        score += 0
      elsif @game_rules.winning_gamepiece == "o"
        score += 1
      else
        score -= 1
      end
    end
  
    def reset_board_and_counters(move_history)
      move_history.keys.each do |key|
        board_space_value = (key).to_s
        @board.spaces[key-1] = board_space_value
      end
    end
  end
end
