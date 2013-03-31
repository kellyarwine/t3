module T3
  class Configurations
    attr_accessor :board, :io, :prompter, :player_1, :player_2, :players, :game_rules, :validations

    def initialize(prompter)
      @prompter = prompter
      @prompter = Prompter.new
    end

    def configure_game
      build_board
      @game_rules = GameRules.new(@board)
      @validations = Validations.new
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
        when "1" then Player::EasyAiStrategy.new(ai_gamepiece)
        when "2" then Player::MinimaxStrategy.new(ai_gamepiece,@game_rules)
        when "3" then Player::HumanStrategy.new(@prompter.human_gamepiece,@prompter)
      end
    end

    def ai_gamepiece
      gamepiece = "x"

      if @validations.invalid_gamepiece?(gamepiece)
        gamepiece = "o"
      else
        return gamepiece
      end

    end

    def setup_turn_order
      case @prompter.turn_order(@players)
      when "1" then @players
      when "2" then @players.reverse!
      end
    end

  end
end
