require 't3/game_rules'
require 't3/player/easy_ai'
require 't3/player/human'
require 't3/player/minimax'

module T3
  class Configurations
    attr_accessor :board, :player_1, :player_2, :players, :game_rules

    def configure_game(configurations_selections)
      build_board(configurations_selections[:board_size])
      @game_rules = GameRules.new(@board)
      setup_players(configurations_selections[:opponent], configurations_selections[:human_gamepiece], configurations_selections[:opponent_gamepiece])
      setup_turn_order(configurations_selections[:turn_order])
    end

    def build_board(board_size)
      @board = Board.new(board_size)
    end

    def setup_players(opponent_selection, human_gamepiece, opponent_gamepiece)
      @player_1 = Player::Human.new(human_gamepiece)
      @player_2 = opponent(opponent_selection, human_gamepiece, opponent_gamepiece)
      @players = [@player_1,@player_2]
    end

    def opponent(opponent_selection, human_gamepiece, opponent_gamepiece)
      case opponent_selection
        when "1" then Player::EasyAi.new(opponent_gamepiece)
        when "2" then Player::Minimax.new(opponent_gamepiece, @game_rules)
        when "3" then Player::Human.new(human_gamepiece)
      end
    end

    def setup_turn_order(turn_order_selection)
      case turn_order_selection
      when "1" then @players
      when "2" then @players.reverse!
      end
    end

  end
end
