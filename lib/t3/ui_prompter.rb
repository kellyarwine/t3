require 't3/validations'

module T3
  class UiPrompter
    attr_accessor :io, :validations, :board_size, :opponent, :human_gamepiece, :turn_order

    def initialize
      @io = T3::Io.new
      @validations = T3::Validations.new
    end

    def get_board_size(size)
      @board_size ||= size
    end

    def get_opponent(opponent)
      @opponent ||= opponent
    end

    def get_human_gamepiece(human_gamepiece)
      @human_gamepiece ||= human_gamepiece
    end

    def ai_gamepiece
      gamepiece = "x"

      if @validations.invalid_gamepiece?(gamepiece)
        gamepiece = "o"
      else
        return gamepiece
      end

    end

    def get_turn_order(turn_order)
      @turn_order ||= turn_order
    end

    def human_move(board)
      human_move_selection = display_and_get_human_move

      while @validations.invalid_move?(human_move_selection,board)
        @io.display_invalid_selection
        human_move_selection = display_and_get_human_move
      end

      return human_move_selection
    end




  end
end