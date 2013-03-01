class ConsoleIo
  attr_accessor :input, :output, :gamepiece, :board_row

  HUMAN_LABEL = "Human"
  AI_LABEL = "Computer"
  SPACE_LENGTH = 5
  BLANK_SPACE = " "
  GRID_HORIZONTAL_LINE = "-"
  GRID_CROSSHAIRS = "+"
  GRID_VERTICAL_LINE = "|"
  LINE_END = "\n"

  def initialize(input = nil, output = nil)
    @input, @output = input, output
  end
  
  def input
    @input ||= STDIN
  end

  def output
    @output ||= STDOUT
  end

  def display(message)
    output.puts message
  end

  def get
    input.gets.chomp
  end

  def display_and_get(message)
    display(message)
    input.gets.chomp
  end

  def display_invalid_selection
    display("Invalid selection.  Please try again.")
  end

  def player_label(player)
    player.human? == true ? HUMAN_LABEL : AI_LABEL
  end

  def display_and_get_opponent
    display("Choose your opponent:\n\n")
    display("1. #{AI_LABEL}\n")
    display_and_get("2. #{HUMAN_LABEL}\n")
  end

  def display_and_get_board(board_sizes)
    display("Choose the board size:\n\n")
    board_sizes.each_with_index { |size,i| display("#{i+1}. #{size}\n") }
    input.gets.chomp
  end

  def display_and_get_gamepiece
    display_and_get("Choose any letter to be your gamepiece.")
  end

  def display_and_get_turn_order(player_1,player_2)
    display("Choose which player goes first:\n\n")
    display("1. #{player_label(player_1)}\n")
    display_and_get("2. #{player_label(player_2)}\n")
  end

  def display_welcome_message
    display("\nWelome to T3!  Get ready to lose.\n\n")
  end

  def display_gameboard(spaces, row_column_size)
    @spaces = spaces
    display(construct_gameboard(spaces, row_column_size))
    # construct_gameboard(spaces, row_column_size)
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
    row.map { |marker| "  %-2s " % marker }
       .join("|") <<
       LINE_END
  end

  def generate_grid_row(row_column_size)
    row_column_size.times
                   .map { GRID_HORIZONTAL_LINE * SPACE_LENGTH }
                   .join(GRID_CROSSHAIRS) <<
                   LINE_END
  end

  def display_request_for_move(player)
    display("#{player_label(player)}, please enter a move (1-9):")
  end

  def display_win(gamepiece)
    display("#{gamepiece} wins!")
  end

  def display_draw
    display("The game is a draw.")
  end

  def display_and_get_play_again
    display_and_get("Would you like to play again?")
  end

end 
