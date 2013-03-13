module T3
  module Player
    class Human
      attr_reader :console_io, :piece
    
      def initialize(piece,console_io)
        @piece = piece
        @console_io = console_io
      end
    
      def human?
        true
      end
    
      def get_move
        @console_io.get.to_i
      end
    
    end
  end
end
