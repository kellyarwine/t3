require 't3/board'
require 't3/game_rules'
require 't3/validations'
require 't3/player/player_context'

module T3
  class Configurations
    attr_accessor :board, :console_io, :player_1, :player_2, :players, :game_rules, :validations

    BOARD_SIZES = {
      "1" => 3,
      "2" => 4,
      "3" => 5
    }

    def initialize(console_io)
      @console_io = console_io
    end

    def configure_game
      build_board
      @game_rules = GameRules.new(@board)
      @validations = Validations.new(@board)
      setup_players
      setup_turn_order
    end

    def build_board
      @board = Board.new(board_size)
    end

    def board_size
      @console_io.display_board_size_prompt(BOARD_SIZES.values)

      board_size_selection = @console_io.get

      if BOARD_SIZES[board_size_selection].nil?
        @console_io.display_invalid_selection
        board_size
      else
        BOARD_SIZES[board_size_selection].to_i
      end
    end

    def setup_players
      @player_1 = Player::PlayerContext.new(Player::HumanStrategy.new(human_gamepiece,@console_io))
      @player_2 = Player::PlayerContext.new(opponent)
      @players = [@player_1,@player_2]
    end

    def opponent
      @console_io.display_opponent_prompt
      get_opponent
    end

    def get_opponent
      case @console_io.get
        when "1" then Player::EasyAiStrategy.new(ai_gamepiece)
        when "2" then Player::MinimaxStrategy.new(ai_gamepiece,@game_rules)
        when "3" then Player::HumanStrategy.new(human_gamepiece,@console_io)
      else
        @console_io.display_invalid_selection
        opponent
      end
    end

    def human_gamepiece
      @console_io.display_gamepiece_prompt
      get_human_gamepiece
    end

    def get_human_gamepiece
      gamepiece = @console_io.get.downcase

      if @validations.invalid_gamepiece?(gamepiece)
        @console_io.display_invalid_selection
        human_gamepiece
      else
        @validations.store_gamepiece(gamepiece)
        gamepiece
      end
    end

    def ai_gamepiece
      gamepiece = "x"

      if @validations.invalid_gamepiece?(gamepiece)
        gamepiece = "o"
      else gamepiece
      end
    end

    def setup_turn_order
      @console_io.display_turn_order_prompt(@players)

      case @console_io.get
      when "1" then @players
      when "2" then @players.reverse!
      else
        @console_io.display_invalid_selection
        setup_turn_order
      end
    end

  end
end
