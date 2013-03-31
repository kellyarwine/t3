module T3
  class Io
    attr_accessor :input, :output, :gamepiece, :board_row

    HUMAN_LABEL = "Human"
    AI_LABEL = "Computer"
    OPPONENTS = ["Easy AI", "Hard AI", "Human"]
    SPACE_LENGTH = 5
    BLANK_SPACE = " "
    GRID_HORIZONTAL_LINE = "-"
    GRID_CROSSHAIRS = "+"
    GRID_VERTICAL_LINE = "|"
    LINE_END = "\n"

    def initialize
      @input, @output = $stdin, $stdout
    end

    def display(message)
      output.puts message
    end

    def get
      input.gets.chomp
    end

    def display_invalid_selection
      display("Invalid selection.  Please try again.")
    end

    def player_label(player)
      player.human? == true ? HUMAN_LABEL : AI_LABEL
    end

    def display_welcome_message
      display("\nWelome to T3!  Get ready to lose.\n\n")
    end

    def display_gameboard(spaces, row_column_size)
      @spaces = spaces
      display(construct_gameboard(spaces, row_column_size))
    end

    def construct_gameboard(spaces, row_column_size)
      generate_margin(row_column_size) <<
        spaces.each_slice(row_column_size)
              .map { |row| generate_row row }
              .join(generate_grid_row row_column_size) <<
      generate_margin(row_column_size)
    end

    def generate_margin(row_column_size)
      row_column_size.times
                     .map { BLANK_SPACE * SPACE_LENGTH }
                     .join(GRID_VERTICAL_LINE) <<
                     LINE_END
    end

    def generate_row(row)
      row.map { |marker| "  %-2s " % marker }.join("|") << LINE_END
    end

    def generate_grid_row(row_column_size)
      row_column_size.times
                     .map { GRID_HORIZONTAL_LINE * SPACE_LENGTH }
                     .join(GRID_CROSSHAIRS) <<
                     LINE_END
    end

    def display_win(gamepiece)
      display("#{gamepiece} wins!")
    end

    def display_draw
      display("The game is a draw.")
    end

    def display_play_again_prompt
      display("Would you like to play again?")
    end

  end
end
