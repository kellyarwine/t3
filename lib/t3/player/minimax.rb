module T3
  module Player  
    class Minimax
      RESET_SCORE_VALUE = 0
      DRAW_SCORE_VALUE = 0.0
      WIN_SCORE_VALUE = 1.0
      LOSE_SCORE_VALUE = -1.0
      MAXIMUM_DEPTH = 4

      attr_accessor :board, :game_rules, :piece

      def initialize(board,game_rules,piece)
        @board = board
        @game_rules = game_rules
        @piece = piece
      end

     def human?
        false
     end

     def current_player(gamepieces)
      gamepieces.first
     end

     # def maximum_depth(depth,available_spaces_length)
        # case available_spaces_length
        # when 6..9 then 2
        # when 5    then 3
        # else
        #   depth
        # end
     # end
    
      def get_move(board,gamepieces)
        require 'pry'
        score_array = minimax(board,gamepieces)
        max_score_index = score_array.index(score_array.max)
        space = board.available_spaces_by_position[max_score_index]
        (space+1).to_i
      end
    
      def minimax(board,gamepieces,depth=0)
        score_array = Array.new

        board.available_spaces_by_position.each do |available_space|
          board.spaces[available_space] = current_player(gamepieces)
          depth += 1

          score_array << score_board(board,gamepieces,depth) if depth <= MAXIMUM_DEPTH

          board = unwind_board(board,available_space)
          depth -= 1
        end
        score_array        
      end

      def score_board(board,gamepieces,depth)
        if @game_rules.game_over?
          score = score_win(depth)
          # binding.pry if board.spaces == ["o","x","3","o","o","x","o","8","x"]
        else
          # binding.pry if board.spaces == ["o","x","3","o","o","x","o","8","x"]
          scores = minimax(board,gamepieces.reverse,depth)
          # score = pick_matrix_scorere(scores,gamepieces)
          # binding.pry
          scores.map! { |e| e ? e : 0 }
          score = scores.min
        end
        score
      end
    
      def score_win(depth)
        case @game_rules.winning_gamepiece
        when nil then DRAW_SCORE_VALUE
        when @piece then WIN_SCORE_VALUE/depth
        else
          LOSE_SCORE_VALUE/depth
        end
      end
      
      def unwind_board(board,occupied_space)
        board.spaces[occupied_space] = (occupied_space + 1).to_s
        board
      end

      def pick_score(scores,gamepieces)
        @piece == gamepieces.first ? scores.max : scores.min
      end

      def pick_matrix_score(score,returned_score,gamepieces)
        @piece == gamepieces.first ? [score,returned_score].max : [score,returned_score].min
      end

      def unwind_matrix_board(move_history)
        move_history.keys.each { |key| @board.spaces[key.to_i-1] = key }
      end

      def minimax_matrix(board,gamepieces,score=0,depth=0,output=" "*11,output_s=" "*10,output_2=" "*3,output_2s=" "*2,output_3=" ",output_3s="",output_4=" ",output_4s="")
        require 'pry'
        
        board.available_spaces_by_name.each_with_index do |available_space,i|
          # binding.pry
          move_history = Hash.new
          depth += 1

          if depth == 1  
            output    << available_space + " " * 23
          elsif depth == 2
            output_2  << available_space + " " * 7
          elsif depth == 3
            output_3  << available_space + " " * 3
          elsif depth == 4
            output_4  << available_space + " " * 3
          end          

          position = board.spaces.index(available_space)
          board.spaces[position] = current_player(gamepieces)

          move_history[available_space] = current_player(gamepieces)


          returned_score = minimax_matrix(board,gamepieces.reverse,score,depth,output,output_s,output_2,output_2s,output_3,output_3s,output_4,output_4s) if not @game_rules.game_over?
          score = score_win(depth)

          if not returned_score.nil?
            score = pick_matrix_score(score,returned_score,gamepieces)
          end

          if depth == 1
            output_s   << "#{score.round(1)}" + " " * 21
          elsif depth == 2
            output_2s  << "#{score.round(1)}" + " " * 5
          elsif depth == 3
            output_3s  << "#{score.round(1)}" + " " * 1
          elsif depth == 4
            output_4s  << "#{score.round(1)}" + " " * 1
          end

          if @game_rules.game_over?
            if depth == 1  
              output_2  << " " * 24
              output_2s << " " * 24
              output_3  << " " * 24
              output_3s << " " * 24
              output_4  << " " * 24
              output_4s << " " * 24
            elsif depth == 2
              output_3  << " " * 8
              output_3s << " " * 8
              output_4  << " " * 8
              output_4s << " " * 8
            elsif depth == 3
              output_4  << " " * 4
              output_4s << " " * 4
            end
          end
         
          puts "----------------------------------------------------------------------------------------------------"
          puts output
          puts output_s
          puts output_2
          puts output_2s
          puts output_3
          puts output_3s
          puts output_4
          puts output_4s
# binding.pry
          
          unwind_matrix_board(move_history)
          depth -= 1
          score
        end
        score
      end
    end
  end
end
