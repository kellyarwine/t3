require 't3/board'
require 't3/player'
require 't3/console_io'

module T3
  class Validations
    attr_accessor :board, :gamepieces
  
    def initialize(board)
      @board = board
      @gamepieces = []
    end
  
    def invalid_move?(space)
       not input_valid_integer?(space) && space_open?(space)
    end
  
    def input_valid_integer?(space)
      !!(space.to_s =~ /^[1-9]$/)
    end
  
    def space_open?(space)
      @board.spaces[space-1].nil?
    end
  
    def invalid_gamepiece?(gamepiece)
       not one_character? || duplicate_gamepiece
    end
  
    def duplicate_gamepiece?(gamepiece)
      @gamepieces << gamepiece
      not @gamepieces.length == @gamepieces.uniq.length
    end
  
    def one_character?(gamepiece)
      gamepiece.length == 1
    end 
  
    # def input_valid_gamepiece?(space)
    # 	!!(space.to_s =~ /^[1-9]$/)
    # end
  
  end
end
