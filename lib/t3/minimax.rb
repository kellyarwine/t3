module T3
  class Minimax
    RESET_SCORE_VALUE = 0
    DRAW_SCORE_VALUE = 0.0
    WIN_SCORE_VALUE = 1.0
    LOSE_SCORE_VALUE = -1.0
    attr_accessor :board, :game_rules, :console_io

    def initialize(board,game_rules,console_io)
      @board = board
      @game_rules = game_rules
      @console_io = console_io
    end

    def current_player(gamepieces)
      gamepieces.first
    end

    def recursion_depth
      case @board.available_spaces
      when between?(8,9) then 2
      when between?(6,7) then 3
      when between?(4,5) then 5
      else
        @board.available_spaces.length
    end
  
    def get_move(gamepieces)
      @score_hash = Hash.new

      @board.available_spaces.each_with_index do |available_space, i|
        minimax(gamepieces)
      end

      max_score = @score_hash.values.max
      @score_hash.select { |k,v| v == max_score }.keys
                                                 .shift
                                                 .strip
    end
  
    def minimax(gamepieces,depth=0)
      score = 0

      @board.available_spaces.each_with_index do |available_space,i|
        move_history = Hash.new
        depth += 1

        position = @board.spaces.index(available_space)
        @board.spaces[position] = current_player(gamepieces)
        move_history[available_space] = current_player(gamepieces)

        score += minimax(gamepieces.reverse,depth) if not @game_rules.game_over?
        score += score_win(depth)

        if final_depth_layer?(depth)
          store_score(depth,score,available_space)
          score = RESET_SCORE_VALUE
        end
        
        unwind_board(move_history)

        depth -= 1
      end

      score
    end

    def final_depth_layer?(depth)
      depth == 1
    end
  
    def score_win(depth)
      case @game_rules.winning_gamepiece
      when nil then DRAW_SCORE_VALUE
      when "o" then WIN_SCORE_VALUE/depth
      else
        LOSE_SCORE_VALUE/depth
      end
    end

    def store_score(depth,score,space)
      @score_hash[space] = score.round(3)
    end
  
    def unwind_board(move_history)
      move_history.keys.each { |key| @board.spaces[key.to_i-1] = key }
    end
  end
end
