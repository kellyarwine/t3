require 't3/console_io'
require 't3/validations'
require 't3/player/easy_ai'
require 't3/player/minimax'
require 't3/player/human'

module T3
  module Player
    class PlayerBuilder
      attr_accessor :console_io, :validations, :gamepiece

      def initialize(console_io,validations)
        @console_io = console_io
        @validations = validations
      end

      def create(type,game_rules)
        PLAYER_TYPES[type].new(gamepiece(input),ai_gamepiece,game_rules,@console_io)
      end

      def gamepiece(type)
        if type == Player::EasyAI || type
          @gamepiece = human_gamepiece
        else
          @gamepiece ||= human_gamepiece
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
          get_human_gamepiece
        else
          @validations.store_gamepiece(gamepiece)
          gamepiece
        end
      end

      def ai_gamepiece
        gamepiece = "x"
        @validations.store_gamepiece(gamepiece)
        gamepiece
      end

    end
  end
end
