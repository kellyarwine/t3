require 't3/console_io'
require 't3/configurations'
require 't3/game'

module T3
  class GameRunner
    attr_accessor :console_io, :game, :configurations

    def initialize
      @console_io = ConsoleIo.new
      @configurations = Configurations.new(@console_io)
      @game = Game.new(@console_io,@configurations)
    end

    def play_game
      run_game
      play_game if play_again?
    end

    def run_game
      @configurations.configure_game
      @game.configurations = @configurations
      @game.start_game
    end

    def play_again?
      @console_io.display_play_again_prompt

      case @console_io.get.downcase
      when "y" then true
      when "n" then false
      else
        @console_io.display_invalid_selection
        play_again?
      end
    end

  end
end
