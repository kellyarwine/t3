module T3
  module Player
    class Human
      attr_reader :prompter, :piece

      def initialize(piece)
        @piece = piece
      end

      def human?
        true
      end

    end
  end
end
