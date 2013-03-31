module T3
  module Player
    class HumanStrategy
      attr_reader :prompter, :piece

      def initialize(piece,prompter)
        @piece = piece
        @prompter = prompter
      end

      def human?
        true
      end

      def move
        @prompter.human_move
      end

    end
  end
end
