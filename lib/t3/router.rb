require 't3/game_runner'

module T3
  class Router

    def call(env)
      @request = Rack::Request.new(env)
      case @request.path
      when "/"
        Rack::Response.new do |response|
          response.body = [render("index.html.erb")]

        end
      when "/configure"
        Rack::Response.new do |response|
          require 'pry'
          binding.pry
          board
          config_hash = Rack::Utils.parse_query(@request.env["QUERY_STRING"])
          board(config_hash["size"].to_i)
          config_hash["gamepiece"]
          config_hash["opponent"]
          config_hash["first_player"]
          response.redirect("/")
        end
      when "/space"
        Rack::Response.new do |response|
          response.redirect("/" + Rack::Utils.build_query(
                                    spaces: @board.spaces
                                  ))
        end
      else
        Rack::Response.new("Not Found",404)
      end
    end

    def initialize(input,output)
      @io = Io.new(input,output)
      @configurations = Configurations.new(@io)
      @game_runner = T3::GameRunner.new(input,output)
    end

    def board(size)
      @configurations.build_board = Board.new(size)
    end

    def player_1
      @human = HumanStrategy.new(piece,@io)
    end

    def_player_2

    end

    def render(template)
      path = File.expand_path("../views/#{template}", __FILE__)
      ERB.new(File.read(path)).result(binding)
    end

  end
end