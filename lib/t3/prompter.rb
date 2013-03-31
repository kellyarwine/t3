module T3
  class Prompter
    attr_accessor :io, :validations

    OPPONENT_SELECTIONS = {
      "1" => "Easy AI",
      "2" => "Hard AI",
      "3" => "Human"
    }
    BOARD_SIZE_SELECTIONS = {
      "1" => 3,
      "2" => 4,
      "3" => 5
    }

    def initialize
      @io = T3::Io.new
      @validations = T3::Validations.new
    end

   def board_size
      board_size_selection = display_and_get_board_size

      while @validations.invalid_selection?(board_size_selection,BOARD_SIZE_SELECTIONS)
        @io.display_invalid_selection
        board_size_selection = display_and_get_board_size
      end

      return BOARD_SIZE_SELECTIONS[board_size_selection]
    end

    def display_and_get_board_size
      display_board_size_prompt
      return @io.get
    end

    def display_board_size_prompt
      @io.display("Choose the board size:\n\n")
      BOARD_SIZE_SELECTIONS.values.each_with_index { |size,i| @io.display("#{i+1}. #{size}x#{size}\n") }
    end

    def opponent
      opponent_selection = display_and_get_opponent

      while @validations.invalid_selection?(opponent_selection,OPPONENT_SELECTIONS)
        @io.display_invalid_selection
        opponent_selection = display_and_get_opponent
      end

      return opponent_selection
    end

    def display_and_get_opponent
      display_opponent_prompt
      return @io.get
    end

    def display_opponent_prompt
      @io.display("Choose your opponent:\n\n")
      OPPONENT_SELECTIONS.each_with_index { |opponent, i| @io.display("#{i+1}. #{opponent}\n") }
    end

    def human_gamepiece
      human_gamepiece_selection = display_and_get_human_gamepiece

      while @validations.invalid_gamepiece?(human_gamepiece_selection)
        @io.display_invalid_selection
        human_gamepiece_selection = display_and_get_human_gamepiece
      end

      @validations.store_gamepiece(human_gamepiece_selection)
      return human_gamepiece_selection
    end

    def display_and_get_human_gamepiece
      display_gamepiece_prompt
      @io.get.downcase
    end

    def display_gamepiece_prompt
      @io.display("Choose any letter to be the gamepiece.")
    end

    def turn_order(players)
      turn_order_selection = display_and_get_turn_order(players)

      while @validations.invalid_turn_order_selection?(turn_order_selection,players)
        @io.display_invalid_selection
        turn_order_selection = display_and_get_turn_order(players)
      end

      return turn_order_selection
    end

    def display_and_get_turn_order(players)
      display_turn_order_prompt(players)
      @io.get
    end

    def display_turn_order_prompt(players)
      @io.display("Choose which player goes first:\n\n")
      players.each_with_index { |player, i| @io.display("#{i+1}. #{@io.player_label(player)}\n") }
    end

    def human_move(board)
      human_move_selection = display_and_get_human_move

      while @validations.invalid_move?(human_move_selection,board)
        @io.display_invalid_selection
        human_move_selection = display_and_get_human_move
      end

      return human_move_selection
    end

    def display_and_get_human_move
      display_human_move_prompt
      @io.get.to_i
    end

    def display_human_move_prompt
      @io.display("Human, please enter a move (1-9):")
    end

  end
end