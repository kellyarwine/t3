module T3
  class Game
    attr_reader :configurations

    def initialize(configurations)
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

    def current_player
      players.first
    end

    def game_loop(move)
      place_move(move)
      switch_current_player
    end

    def game_state
      game_rules.game_state
    end

    def place_move(move)
      board.place_move(current_player.piece, move)
    end

    def switch_current_player
      players.reverse!
    end

  end
end
