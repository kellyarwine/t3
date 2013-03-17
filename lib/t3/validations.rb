require 't3/board'

module T3
  class Validations
    attr_accessor :board, :gamepieces

    def initialize(board)
      @board = board
      @gamepieces = []
    end

    def invalid_move?(space)
       (not space_open?(space) && in_board_range?(space) && valid_integer?(space))
    end

    def valid_integer?(space)
      space.to_s =~ /\d/
    end

    def in_board_range?(space)
      space.between?(1,@board.size**2)
    end

    def space_open?(space)
      @board.spaces[space-1] =~ /\d/
    end

    def invalid_gamepiece?(gamepiece)
       (not valid_letter?(gamepiece) && one_character?(gamepiece)) || duplicate_gamepiece?(gamepiece)
    end

    def one_character?(gamepiece)
      gamepiece.length == 1
    end

    def duplicate_gamepiece?(gamepiece)
      gamepieces.include? gamepiece
    end

    def valid_letter?(gamepiece)
    	gamepiece =~ /[a-zA-Z]/
    end

    def store_gamepiece(gamepiece)
      gamepieces << gamepiece
    end

    def gamepieces
      @gamepieces ||= []
    end

  end
end
