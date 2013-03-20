require_relative 'board'
require 'json'

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

    def board_spaces
      if @request.cookies["board_spaces"].nil?
        @board.spaces
      else
        JSON.parse(@request.cookies["board_spaces"])
      end
    end

    def print_board
      if @request.cookies["board_spaces"].nil?
        "This is the initial board: #{"#0x%08x" % (@board.object_id * 2)}"
      else
        "This is the serialized_board: #{JSON.parse(@request.cookies["board_spaces"])}"
      end
    end

    def response
      case @request.path
      when "/" then Rack::Response.new(render("index.html.erb"))
      when "/space"
        Rack::Response.new do |response|
          response.set_cookie("space", @request.params["space"])
          board_spaces[@request.cookies["space"]] = "x"
          serialized_board_spaces = @board.spaces.to_json
          response.set_cookie("board_spaces", serialized_board_spaces)
          response.redirect("/")
        end
      else
        Rack::Response.new("Not Found",404)
      end
    end

    def render(template)
      path = File.expand_path("../views/#{template}", __FILE__)
      ERB.new(File.read(path)).result(binding)
    end

  end
end