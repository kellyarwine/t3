module T3
  module Player
    class HumanStrategy
      attr_reader :console_io, :piece

      def initialize(piece,console_io)
        @piece = piece
        @console_io = console_io
      end

      def human?
        true
      end

      def move
        @console_io.get.to_i
      end

    end
  end
end
