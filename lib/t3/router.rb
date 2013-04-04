require 't3/game_runner'
require 't3/ui_prompter'

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
          config_hash = Rack::Utils.parse_query(@request.env["QUERY_STRING"])
          @prompter.set_board_size(config_hash["size"].to_i)
          @prompter.set_human_gamepiece(config_hash["gamepiece"])
          @prompter.set_opponent(config_hash["opponent"])
          @prompter.set_turn_order(config_hash["first_player"])
          build_board
          setup_players
          setup_turn_order
          response.redirect("/")
        end
      when "/board"
        Rack::Response.new do |response|
          @configurations.board.place_move("x",config_hash["board"].to_i)
          response.redirect("/" + Rack::Utils.build_query(
                                    spaces: @board.spaces
                                  ))
        end
      else
        Rack::Response.new("Not Found",404)
      end
    end

    def initialize
      @prompter = UiPrompter.new
      @configurations = Configurations.new(@prompter)
      @game_runner = T3::GameRunner.new
    end

    def build_board
      @configurations.build_board
    end

    def setup_players
      @configurations.setup_players
    end

    def setup_turn_order
      @configurations.setup_turn_order
    end

    def board_spaces(space)
      @configurations.board.spaces[space]
    end

    def render(template)
      path = File.expand_path("../views/#{template}", __FILE__)
      ERB.new(File.read(path)).result(binding)
    end

  end
end