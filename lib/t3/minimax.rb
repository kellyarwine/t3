module T3
  class Minimax
    attr_accessor :board, :game_rules, :console_io, :starting_move, :players, :current_gamepiece, :move_history
  
    def initialize(board,game_rules,console_io)
      @board = board
      @game_rules = game_rules
      @console_io = console_io
      @starting_move_and_score = Hash.new [ 0 ]
      @gamepieces = ["x","o"]
      @current_gamepiece = "x"
    end
  
    def swap_current_gamepiece
      @current_gamepiece = @gamepieces.reverse!.first
    end
  
    def start_scorer(available_spaces)
      print @board.spaces
      puts "\n----------------------------------------------\n"
      run_scorer(available_spaces, @gamepieces)    
    end
  
    def run_scorer(available_spaces,gamepieces,score,p1 = nil,p2 = nil,p3 = nil)
  require 'pry'
      move_history = Hash.new
      for i in 1..available_spaces.length
        # binding.pry

        position = @board.spaces.index(available_spaces[i-1])
        @board.spaces[position] = gamepieces.first
        move_history[position+1] = gamepieces.first

        puts "----------------------------------------------\n"  
        print "for #{i} in 1..#{available_spaces.length}"
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
        
        
          run_scorer(@board.available_spaces,gamepieces.reverse,score,move_history,p1,p2) if not @game_rules.game_over?
          score = score_win(score)
        
            puts "----------------------------------------------\n"
            print "#{score}"
            print "\n"
          if @game_rules.win_game?
            puts "#{@game_rules.winning_gamepiece} wins!\n"
          else
            puts "Draw."
          end
            puts "----------------------------------------------\n"
      
          reset_board_and_counters(move_history)
      end
    end
  
    def display_gameboard
      @console_io.display_gameboard(@board.spaces,3)
    end
  
    def score_win(score)
      # binding.pry
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
      
      @starting_move_and_score[move_history.keys.first] = @score
    end
  end
end
