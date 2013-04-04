require 'console/io'
require 'console/prompter'
require 't3/game'
require 't3/configurations'

module Console
  class Console
    attr_accessor :prompter, :io, :game, :configurations

    def initialize
      @io = Io.new
      @prompter = Prompter.new(@io)
      @configurations = T3::Configurations.new
      @game = T3::Game.new(@configurations)
    end

    def run_game
      configure_game
      play_game
      run_game if @prompter.play_again?
    end

    def configure_game
      get_configurations
      @configurations.configure_game(configurations_selections)
    end

    def configurations_selections
      configurations_selections = Hash.new
      configurations_selections[:board_size] = @board_size
      configurations_selections[:opponent] = @opponent
      configurations_selections[:human_gamepiece] = @human_gamepiece
      configurations_selections[:opponent_gamepiece] = @opponent_gamepiece
      configurations_selections[:turn_order] = @turn_order
      configurations_selections
    end

    def get_configurations
      @board_size = @prompter.board_size
      @opponent = @prompter.opponent
      @human_gamepiece = @prompter.human_gamepiece
      @opponent_gamepiece = @prompter.opponent_gamepiece(@opponent)
      @turn_order = @prompter.turn_order
    end

    def play_game
      display_welcome_message

      while @game.game_state == ""
        display_gameboard
        get_move
        @game.game_loop(@move)
      end

      display_gameboard
      @game.game_state == "draw" ? display_draw : display_win
    end

    def display_welcome_message
      @io.display_welcome_message
    end

    def display_gameboard
      @io.display_gameboard(@game.board.spaces,@game.board.size)
    end

    def get_move
      case @game.current_player
        when T3::Player::EasyAi then @move = @game.current_player.move(@game.board)
        when T3::Player::Minimax then @move = @game.current_player.move(@game.board, [@game.player_2.piece, @game.player_1.piece])
        when T3::Player::Human then @move = @prompter.human_move(@game.board)
      end
    end

    def display_win
      @io.display_win(@game.game_rules.winning_gamepiece)
    end

    def display_draw
      @io.display_draw
    end

  end
end