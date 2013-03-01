require 't3/player'

module T3
  class Human < Player
    attr_accessor :console_io
  
    def initialize(piece,console_io)
      super(piece)
      @console_io = console_io
    end
  
    def human?
      true
    end
  
    def get_move(available_spaces)
      @console_io.get.to_i
    end
  
  end
end
