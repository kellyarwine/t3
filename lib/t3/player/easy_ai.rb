module T3
  module Player
    class EasyAi
      attr_reader :piece

      def initialize(human_piece,ai_piece,game_rules,console_io)
        @piece = ai_piece
      end

      def human?
        false
      end

      def get_move(board,gamepieces)
        board.available_spaces_by_name.sample.to_i
      end
    end
  end
end
