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
          @prompter.get_board_size(config_hash["size"].to_i)
          @prompter.get_human_gamepiece(config_hash["gamepiece"])
          @prompter.get_opponent(config_hash["opponent"])
          @prompter.get_turn_order(config_hash["first_player"])
          build_board
          setup_players
          setup_turn_order
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

    def render(template)
      path = File.expand_path("../views/#{template}", __FILE__)
      ERB.new(File.read(path)).result(binding)
    end

  end
end