module T3
  module Player
    class EasyAiStrategy
      attr_reader :piece

      def initialize(piece)
        @piece = piece
      end

      def human?
        false
      end

      def move(board,gamepieces)
        board.available_spaces_by_name.sample.to_i
      end
    end
  end
end
