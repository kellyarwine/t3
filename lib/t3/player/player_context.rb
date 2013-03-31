require 't3/io'
require 't3/validations'
require 't3/player/easy_ai_strategy'
require 't3/player/minimax_strategy'
require 't3/player/human_strategy'

module T3
  module Player
    class PlayerContext
      attr_reader :strategy

      def initialize(strategy)
        @strategy = strategy
      end

      def piece
        @strategy.piece
      end

      def human?
        @strategy.human?
      end

      def move(*args)
        @strategy.move(*args)
      end
    end
  end
end
