require 't3/board'

module T3
  class Validations
    attr_accessor :gamepieces

    def initialize
      @gamepieces = []
    end

    def invalid_selection?(selection,selection_hash)
       selection_hash[selection].nil?
    end

    def invalid_turn_order_selection?(turn_order_selection,players)
       not turn_order_selection.to_i.between?(1,players.count)
    end

    def invalid_move?(space,board)
       (not space_open?(space,board) && in_board_range?(space,board) && valid_integer?(space))
    end

    def space_open?(space,board)
      board.spaces[space-1] =~ /\d/
    end

    def in_board_range?(space,board)
      space.between?(1,board.size**2)
    end

    def valid_integer?(space)
      space.to_s =~ /\d/
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
