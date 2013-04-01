require 't3/game_rules'
require 't3/player/player_context'

module T3
  class Configurations
    attr_accessor :board, :io, :prompter, :player_1, :player_2, :players, :game_rules

    def initialize(prompter)
      @prompter = prompter
    end

    def configure_game
      build_board
      @game_rules = GameRules.new(@board)
      setup_players
      setup_turn_order
    end

    def build_board
      @board = Board.new(@prompter.board_size)
    end

    def setup_players
      @player_1 = Player::PlayerContext.new(Player::HumanStrategy.new(@prompter.human_gamepiece,@prompter))
      @player_2 = Player::PlayerContext.new(opponent)
      @players = [@player_1,@player_2]
    end

    def opponent
      case @prompter.opponent
        when "1" then Player::EasyAiStrategy.new(@prompter.ai_gamepiece)
        when "2" then Player::MinimaxStrategy.new(@prompter.ai_gamepiece,@game_rules)
        when "3" then Player::HumanStrategy.new(@prompter.human_gamepiece,@prompter)
      end
    end

    def setup_turn_order
      case @prompter.turn_order
      when "1" then @players
      when "2" then @players.reverse!
      end
    end

  end
end
