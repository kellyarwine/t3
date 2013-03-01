require 'board'
require 'easy_ai'
require 'human'
require 'game_rules'

class Configurations
  attr_accessor :board, :gamepieces, :console_io, :player_1, :player_2, :players, :game_rules

  BOARD_SIZES = ["3x3","4x4","5x5"]

  def initialize(console_io)
    @console_io = console_io
  end

  def configure_game
    setup_players
    setup_turn_order
    @game_rules = GameRules.new(board)
  end

  def board
    @board ||= Board.new(get_board_size)
  end

  def get_board_size
    case @console_io.display_and_get_board(BOARD_SIZES)
    when "1" then evaluate_board_size(BOARD_SIZES[0])
    when "2" then evaluate_board_size(BOARD_SIZES[1])
    when "3" then evaluate_board_size(BOARD_SIZES[2])
    else
      @console_io.display_invalid_selection
      get_board_size
    end
  end

  def evaluate_board_size(board_size)
    eval(board_size.gsub("x","*"))
  end

  def setup_players
    @player_2 = get_opponent
    @player_1 = human_opponent
  end

  def get_opponent
    case @console_io.display_and_get_opponent
    when "1" then ai_opponent
    when "2" then human_opponent
    else
      @console_io.display_invalid_selection
      get_opponent
    end
  end

  def ai_opponent
    EasyAi.new(ai_gamepiece)
  end

  def human_opponent
    Human.new(display_and_get_human_gamepiece,@console_io)
  end

  def display_and_get_human_gamepiece
    gamepiece = @console_io.display_and_get_gamepiece.downcase

    if invalid_gamepiece?(gamepiece)
      @console_io.display_invalid_selection
      display_and_get_human_gamepiece
    else
      store_gamepiece(gamepiece)
      gamepiece
    end
  end

  def ai_gamepiece
    gamepiece = "x"
    store_gamepiece(gamepiece)
    gamepiece
  end

  def store_gamepiece(gamepiece)
    gamepieces << gamepiece
  end

  def gamepieces
  	@gamepieces ||= []
  end

  def invalid_gamepiece?(gamepiece)
     (not valid_letter?(gamepiece) && length_of_one?(gamepiece)) || duplicate_gamepiece?(gamepiece)
  end

  def duplicate_gamepiece?(gamepiece)
    gamepieces.include? gamepiece
  end

  def valid_letter?(gamepiece)
    !!(gamepiece =~ /[a-zA-Z]/)
  end

  def length_of_one?(gamepiece)
    gamepiece.length == 1
  end
  
  def setup_turn_order	
    case @console_io.display_and_get_turn_order(@player_1,@player_2)
    when "1" then @players = [player_1,player_2]
    when "2" then @players = [player_2,player_1]
    else
      @console_io.display_invalid_selection
      setup_turn_order
    end
  end

end