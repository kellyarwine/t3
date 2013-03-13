module T3
  module Player
    class EasyAi
      attr_reader :piece

      def initialize(piece)
        @piece = piece
      end
    
      def human?
        false
      end
    
      def get_move(available_spaces)
        available_spaces.sample.to_i
      end
    end
  end
end
