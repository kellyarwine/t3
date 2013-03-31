require_relative 'board'

module T3
  class T3Gui

    def self.call(env)
      new(env).response.finish
    end

    def initialize(env)
      @board = Board.new(3)
      @me = self
      @request = Rack::Request.new(env)
    end

    # def board_spaces
    #   if @request.cookies["board_spaces"].nil?
    #     @board.spaces
    #   else
    #     JSON.parse(@request.cookies["board_spaces"])
    #   end
    # end

    def print_board
      if @request.cookies["board_spaces"].nil?
        "This is the initial board: #{"#0x%08x" % (@board.object_id * 2)}"
      end
    end


    def get_move

    end
  end
end