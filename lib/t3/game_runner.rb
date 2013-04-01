require 't3/io'
require 't3/prompter'
require 't3/configurations'
require 't3/game'

module T3
  class GameRunner
    attr_accessor :io, :prompter, :game, :configurations

    def initialize
      @io = Io.new
      @prompter = Prompter.new
      @configurations = Configurations.new(@prompter)
      @game = Game.new(@io, @prompter, @configurations)
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
      @io.display_play_again_prompt

      case @io.get.downcase
      when "y" then true
      when "n" then false
      else
        @io.display_invalid_selection
        play_again?
      end
    end

  end
end
