module T3
  class Game
    attr_accessor :game_rules, :validations, :console_io, :board, :configurations, :move

    def initialize(console_io,configurations)
      @console_io = console_io
      @configurations = configurations
    end

    def board
      @configurations.board
    end

    def player_1
      @configurations.player_1
    end

    def player_2
      @configurations.player_2
    end

    def players
      @configurations.players
    end

    def game_rules
      @configurations.game_rules
    end

    def validations
      @configurations.validations
    end

    def current_player
      players.first
    end

    def start_game
      display_welcome_message
      run_game
    end

    def run_game
      while game_over? == false
        display_gameboard
        get_move
        place_move
        switch_current_player
      end
      display_gameboard
      win_game? ? display_win : display_draw
    end

    def display_welcome_message
      @console_io.display_welcome_message
    end

    def game_over?
      game_rules.game_over?
    end

    def display_gameboard
      @console_io.display_gameboard(board.spaces,board.size)
    end

    def get_move
      @console_io.display_request_for_move(current_player)
      @move = move_constructor

      if validations.invalid_move?(@move)
        @console_io.display_invalid_selection
        get_move
      end
    end

    def move_constructor
      case current_player.strategy
        when T3::Player::EasyAiStrategy then current_player.move(board)
        when T3::Player::MinimaxStrategy then current_player.move(board,[player_2.piece,player_1.piece])
        when T3::Player::HumanStrategy then current_player.move
      end
    end

    def place_move
      board.place_move(current_player.piece, @move)
    end

    def switch_current_player
      players.reverse!
    end

    def win_game?
      game_rules.win_game?
    end

    def display_win
      @console_io.display_win(game_rules.winning_gamepiece)
    end

    def display_draw
      @console_io.display_draw
    end
  end
end
