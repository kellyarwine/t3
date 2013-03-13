module T3
  module Player  
    class Minimax
      RESET_SCORE_VALUE = 0
      DRAW_SCORE_VALUE = 0.0
      WIN_SCORE_VALUE = 1.0
      LOSE_SCORE_VALUE = -1.0

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
    
      def get_move(board,gamepieces)
        @original = board.available_spaces_by_position.length
        score_array = minimax(board,gamepieces)
        max_score_index = score_array.index(score_array.max)
        space = board.available_spaces_by_name[max_score_index].to_i
      end
    
      def minimax(board,gamepieces,depth=0)
        score_array = Array.new
        board.available_spaces_by_position.each do |available_space|
          board.spaces[available_space] = current_player(gamepieces)
          depth += 1

          score_array << score_board(board,gamepieces,depth)

          unwind_board(board,available_space)
          depth -= 1
        end
        score_array
      end

      def unwind_board(board,occupied_space)
        initial_board_value = (occupied_space + 1).to_s
        board.spaces[occupied_space] = initial_board_value
        board
      end

      def score_board(board,gamepieces,depth)
        scores = Array.new

        if @game_rules.game_over?
          score = score_win(depth)
        else
          scores = minimax(board,gamepieces.reverse,depth) if depth <= maximum_depth(@original)
          scores.empty? ? 0 : pick_score(scores,gamepieces)
        end
      end
    
      def score_win(depth)
        case @game_rules.winning_gamepiece
        when nil then DRAW_SCORE_VALUE
        when @piece then WIN_SCORE_VALUE/depth
        else
          LOSE_SCORE_VALUE/depth
        end
      end

     def maximum_depth(original)
      case original
        when 1..4 then 4
        when 5..8 then 5
        else 2
      end
    end

      def pick_score(scores,gamepieces)
        @piece == gamepieces.first ? scores.min : scores.max
      end
    end
  end
end
