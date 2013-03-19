module T3
  class Board
    attr_accessor :spaces, :size, :size

    def initialize(size)
      @size = size
      @spaces = ("1"..(@size**2).to_s).to_a
    end

    def place_move(gamepiece, space)
      @spaces[space-1] = gamepiece
    end

    def available_spaces_by_name
      @spaces.select { |space| space =~ /\d/ }
    end

    def available_spaces_by_position
      (0...@spaces.length).select { |i| @spaces[i] =~ /\d/ }
    end

  end
end
