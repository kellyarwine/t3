module T3
  module Player
    class Human
      attr_reader :console_io, :piece

      def initialize(human_piece,ai_piece,game_rules,console_io)
        @piece = human_piece
        @console_io = console_io
      end

      def human?
        true
      end

      def get_move(board,gamepieces)
        @console_io.get.to_i
      end

    end
  end
end
