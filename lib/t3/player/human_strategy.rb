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

      def move(board)
        @prompter.human_move(board)
      end

    end
  end
end
