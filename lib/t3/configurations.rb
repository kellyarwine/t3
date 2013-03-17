require 't3/board'
require 't3/game_rules'
require 't3/validations'
require 't3/player/player_builder'

module T3
  class Configurations
    attr_accessor :board, :console_io, :player_1, :player_2, :players, :game_rules, :player_builder, :validations

    HUMAN_PLAYER_OPTION = "3"
    BOARD_SIZES = {
      "1" => 3,
      "2" => 4,
      "3" => 5
    }
    PLAYER_TYPES = {
      "1" => Player::EasyAi,
      "2" => Player::Minimax,
      "3" => Player::Human
    }

    def initialize(console_io)
      @console_io = console_io
    end

    def configure_game
      build_board
      @game_rules = GameRules.new(@board)
      @validations = Validations.new(@board)
      @player_builder = T3::Player::PlayerBuilder.new(@console_io,@validations)
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
      @player_1 = @player_builder.create(HUMAN_PLAYER_OPTION,@game_rules)
      @player_2 = @player_builder.create(opponent,@game_rules)
      @players = [@player_1,@player_2]
    end

    def opponent
    @console_io.display_opponent_prompt

    opponent_selection = @console_io.get

    if PLAYER_TYPES[opponent_selection].nil?
      @console_io.display_invalid_selection
      opponent
    else
      PLAYER_TYPES[opponent_selection]
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
